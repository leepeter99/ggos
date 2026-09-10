{...}: {
  # Link individual source files, leaving build/, user databases, and sync writable.
  xdg.dataFile."fcitx5/rime/default.custom.yaml".source = ../../rime/default.custom.yaml;
  xdg.dataFile."fcitx5/rime/rime_ice.custom.yaml".source = ../../rime/rime_ice.custom.yaml;
  xdg.dataFile."fcitx5/rime/personal_phrase.txt".source = ../../rime/personal_phrase.txt;

  # The existing profile contained only keyboard-us and Pinyin.
  # Home Manager backs up the previous profile using backupFileExtension.
  xdg.configFile."fcitx5/profile".text = ''
    [Groups/0]
    Name=Default
    Default Layout=us
    DefaultIM=rime

    [Groups/0/Items/0]
    Name=keyboard-us

    [Groups/0/Items/1]
    Name=rime

    [GroupOrder]
    0=Default
  '';
}
