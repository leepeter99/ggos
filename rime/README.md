# Personal Rime Ice configuration

Simplified Chinese full Pinyin using the upstream `rime_ice` schema. This repository contains only personal source files; install upstream [Rime Ice](https://github.com/iDvel/rime-ice) separately.

## Portable files

- `default.custom.yaml`: imports Ice defaults and selects only `rime_ice`.
- `rime_ice.custom.yaml`: Simplified Chinese, pinned pronouns, punctuation patches.
- `personal_phrase.txt`: read-only custom phrase table: text, code, weight separated by actual TAB characters. Codes are full Pinyin without tones or spaces.
- `validate.py`: real librime tests using a temporary runtime directory; needs Python, PyYAML, and librime.

`ta` prioritizes 祂 before 他/她/它. `ni` prioritizes 祢 before 你; 您 remains at its normal `nin` code. `uu` and `UU` offer literal ü and Ü (select with Space). Rime Ice already supports uppercase codes; the Pinyin alphabet/algebra is untouched, so `lv` still works. Enter commits raw input, as in upstream Ice.

The 32 Catholic vocabulary entries are exact-code custom phrases, not a predictive sentence dictionary. Add entries with the same TAB-separated format; choose an integer weight to order entries sharing a code.

Chinese punctuation: `[]<>,.?!` -> `【】《》，。？！`. Bracket character-selection shortcuts are disabled so brackets also work while composing. Upstream number/URL recognition is retained. ASCII mode passes ASCII punctuation through normally.

## NixOS installation

The `rime/` directory in the GGOS Git repository is the source of truth. Home Manager's `modules/home/rime.nix` references these sources with a relative Nix path and installs only the three configuration files into `$XDG_DATA_HOME/fcitx5/rime/` (normally `~/.local/share/fcitx5/rime/`). Each file is linked individually; the runtime directory remains writable. The Fcitx5 addon is `fcitx5-rime.override { rimeDataPkgs = [ rime-ice ]; }`.

Edit the files in GGOS, add new source files to Git and the module's explicit file list, then rebuild normally. No separate Rime flake input or lock update is needed. Only portable sources are declaratively managed; never copy a live Rime runtime directory into this tree or the Nix store.

## Validation

```sh
python validate.py /path/to/librime.so /path/to/share/rime-data
```

It checks schema selection, candidate ordering, every phrase-table entry, `lv`, Chinese punctuation (including while composing), and ASCII punctuation. Generated test files live only in a temporary directory.

After rebuilding, log out and back in; activate Rime with Ctrl+Space, then try it in one GTK and one Qt application.
