{
  lib,
  ...
}: {
  # Link individual source files, leaving build/, user databases, and sync writable.
  xdg.dataFile = lib.genAttrs (map (name: "fcitx5/rime/${name}") [
    "default.custom.yaml"
    "rime_ice.custom.yaml"
    "personal_phrase.txt"
  ]) (target: {
    source = ../../rime + "/${builtins.baseNameOf target}";
  });

  # The existing profile contained only keyboard-us and Pinyin.
  # Home Manager backs up the previous profile using backupFileExtension.
  xdg.configFile."fcitx5/profile".text = ''
    [Groups/0]
    Name=Default
    Default Layout=us
    DefaultIM=rime

    [Groups/0/Items/0]
    Name=keyboard-us
    Layout=

    [Groups/0/Items/1]
    Name=rime
    Layout=

    [GroupOrder]
    0=Default
  '';
}
