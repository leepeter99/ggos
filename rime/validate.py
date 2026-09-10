#!/usr/bin/env python3
"""Validate sources and test a real librime session in disposable runtime data.
Usage: python validate.py /path/to/librime.so /path/to/shared/rime-data
Requires PyYAML. Does not touch your live input method or user dictionary.
"""
import ctypes as C
import pathlib
import shutil
import sys
import tempfile
import yaml

ROOT = pathlib.Path(__file__).resolve().parent
rows = [tuple(line.split('\t')[:2]) for line in (ROOT / 'personal_phrase.txt').read_text().splitlines()
        if line and not line.startswith('#')]
assert len(rows) == len(set(rows))

class Traits(C.Structure):
    _fields_ = [('data_size', C.c_int)] + [(n, C.c_char_p) for n in (
        'shared_data_dir', 'user_data_dir', 'distribution_name',
        'distribution_code_name', 'distribution_version', 'app_name')]
    _fields_ += [('modules', C.POINTER(C.c_char_p)), ('min_log_level', C.c_int)]
    _fields_ += [(n, C.c_char_p) for n in ('log_dir', 'prebuilt_data_dir', 'staging_dir')]
class Composition(C.Structure):
    _fields_ = [(n, C.c_int) for n in ('length', 'cursor_pos', 'sel_start', 'sel_end')] + [('preedit', C.c_char_p)]
class Candidate(C.Structure):
    _fields_ = [('text', C.c_char_p), ('comment', C.c_char_p), ('reserved', C.c_void_p)]
class Menu(C.Structure):
    _fields_ = [(n, C.c_int) for n in ('page_size', 'page_no', 'is_last_page', 'highlighted_candidate_index', 'num_candidates')]
    _fields_ += [('candidates', C.POINTER(Candidate)), ('select_keys', C.c_char_p)]
class Context(C.Structure):
    _fields_ = [('data_size', C.c_int), ('composition', Composition), ('menu', Menu), ('commit_text_preview', C.c_char_p), ('select_labels', C.POINTER(C.c_char_p))]
class Commit(C.Structure):
    _fields_ = [('data_size', C.c_int), ('text', C.c_char_p)]
def sized(cls):
    obj = cls()
    obj.data_size = C.sizeof(cls) - C.sizeof(C.c_int)
    return obj

lib = C.CDLL(sys.argv[1])
# Stable prefix of the public RimeApi ABI from rime_api.h.
class Api(C.Structure):
    _fields_ = [('data_size', C.c_int)] + [(name, C.c_void_p) for name in (
        'setup set_notification_handler initialize finalize start_maintenance '
        'is_maintenance_mode join_maintenance_thread deployer_initialize prebuild '
        'deploy deploy_schema deploy_config_file sync_user_data create_session '
        'find_session destroy_session cleanup_stale_sessions cleanup_all_sessions '
        'process_key commit_composition clear_composition get_commit free_commit '
        'get_context free_context get_status free_status set_option get_option '
        'set_property get_property get_schema_list free_schema_list '
        'get_current_schema select_schema').split()]
lib.rime_get_api.restype = C.POINTER(Api)
rime = lib.rime_get_api().contents
def api(name, args, result=None):
    return C.CFUNCTYPE(result, *args)(getattr(rime, name))
sid = C.c_size_t
setup = api('setup', [C.POINTER(Traits)])
initialize = api('initialize', [C.POINTER(Traits)])
maintenance = api('start_maintenance', [C.c_int], C.c_int)
join = api('join_maintenance_thread', [])
create = api('create_session', [], sid)
select = api('select_schema', [sid, C.c_char_p], C.c_int)
key = api('process_key', [sid, C.c_int, C.c_int], C.c_int)
clear = api('clear_composition', [sid])
option = api('set_option', [sid, C.c_char_p, C.c_int])
get_context = api('get_context', [sid, C.POINTER(Context)], C.c_int)
free_context = api('free_context', [C.POINTER(Context)], C.c_int)
get_commit = api('get_commit', [sid, C.POINTER(Commit)], C.c_int)
free_commit = api('free_commit', [C.POINTER(Commit)], C.c_int)
finalize = api('finalize', [])

with tempfile.TemporaryDirectory(prefix='rime-personal-test-') as tmp:
    runtime = pathlib.Path(tmp)
    for name in ('default.custom.yaml', 'rime_ice.custom.yaml', 'personal_phrase.txt'):
        shutil.copy2(ROOT / name, runtime / name)
    # The fcitx5-rime package creates this empty base if Ice is the only data package.
    (runtime / 'default.yaml').touch()
    traits = sized(Traits)
    traits.shared_data_dir = str(pathlib.Path(sys.argv[2]).resolve()).encode()
    traits.user_data_dir = tmp.encode()
    traits.app_name = b'rime.personal-test'
    traits.log_dir = tmp.encode()
    traits.min_log_level = 2
    setup(C.byref(traits))
    initialize(C.byref(traits))
    try:
        maintenance(1)
        join()
        defaults = yaml.safe_load((runtime / 'build/default.yaml').read_text())
        assert defaults['schema_list'] == [{'schema': 'rime_ice'}]
        session = create()
        assert session and select(session, b'rime_ice')
        def commit():
            obj = sized(Commit)
            if get_commit(session, C.byref(obj)):
                value = obj.text.decode() if obj.text else ''
                free_commit(C.byref(obj))
                return value
            return ''
        def press(char):
            handled = key(session, ord(char), 0)
            result = commit()
            return result if handled else result + char
        def candidates(code):
            clear(session)
            for char in code:
                assert not press(char), f'Premature commit for {code}'
            obj = sized(Context)
            assert get_context(session, C.byref(obj))
            values = [obj.menu.candidates[i].text.decode() for i in range(obj.menu.num_candidates)]
            free_context(C.byref(obj))
            return values
        for code, expected in [('ta','祂'), ('ni','祢'), ('uu','ü'), ('UU','Ü'), ('nin','您')]:
            values = candidates(code)
            assert values[0] == expected, (code, values)
            assert press(' ') == expected
            print(f'PASS: {code} -> {expected}', flush=True)
        assert any(x in candidates('lv') for x in ('绿', '吕', '旅', '驴', '律', '率'))
        print('PASS: lv produces Pinyin candidates', flush=True)
        for text, code in rows:
            assert text in candidates(code), (code, text)
        print('PASS: all phrases are candidates', flush=True)
        mapping = dict(zip('[]<>,.?!', '【】《》，。？！'))
        for full in (0, 1):
            option(session, b'full_shape', full)
            for char, expected in mapping.items():
                clear(session)
                assert press(char) == expected, (full, char)
            # Confirm brackets work during composition as well.
            candidates('tianzhu')
            assert press('[') == '天主【'
        print('PASS: Chinese punctuation, including brackets while composing', flush=True)
        option(session, b'full_shape', 0)
        option(session, b'ascii_mode', 1)
        clear(session)
        ascii_text = '[] <> , . ? !'
        assert ''.join(press(c) for c in ascii_text) == ascii_text
        print('PASS: ASCII mode preserves [] <> , . ? !', flush=True)
    finally:
        finalize()
