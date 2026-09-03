{
  host,
  username,
  lib,
  ...
}: let
  vars = import ../../hosts/${host}/variables.nix;
  consoleKeyMap = vars.consoleKeyMap or "us";
in {
  nix = {
    settings = {
      download-buffer-size = 200000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-config.cachix.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://flyer-myer.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "flyer-myer.cachix.org-1:giZCeviY2BgmVUxFYvPwpF7Pim68/gWpL9BbqPGiS54="
      ];

      # Add trusted-users setting
      trusted-users = lib.mkAfter [username];

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;
    };
  };
  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    GGOS_VERSION = "2.6.5";
    GGOS = "true";
  };
  console.keyMap = "${consoleKeyMap}";
  system.stateVersion = "23.11"; # Do not change!
}
