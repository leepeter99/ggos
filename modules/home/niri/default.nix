{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ggos.niri;
  configPart = name: cfg.configParts.${name} or "";
  configKdl =
    lib.concatStringsSep "\n"
    (builtins.filter (part: part != "") (map configPart [
      "base"
      "environment"
      "startup"
      "windowRules"
      "binds"
    ]));
in {
  imports = [
    ./binds.nix
    ./env.nix
    ./exec-once.nix
    ./niri.nix
    ./windowrules.nix
  ];

  options.ggos.niri.configParts = lib.mkOption {
    type = lib.types.attrsOf lib.types.lines;
    default = {};
    description = "Named niri KDL config fragments assembled into config.kdl.";
  };

  config = {
    home.packages = with pkgs; [
      xwayland-satellite # X11 app support under niri
      swayidle
    ];

    xdg.configFile."niri/config.kdl".text = configKdl;
  };
}
