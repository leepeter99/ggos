{host, ...}: let
  vars = import ../../../hosts/${host}/variables.nix;
  inherit (vars) terminal;
in {
  ggos.niri.configParts.environment = ''
    environment {
        NIXOS_OZONE_WL "1"
        NIXPKGS_ALLOW_UNFREE "1"
        QT_QPA_PLATFORM "wayland;xcb"
        QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        QT_AUTO_SCREEN_SCALE_FACTOR "1"
        CLUTTER_BACKEND "wayland"
        MOZ_ENABLE_WAYLAND "1"
        ELECTRON_OZONE_PLATFORM_HINT "wayland"
        SDL_VIDEODRIVER "wayland"
        GDK_SCALE "1"
        QT_SCALE_FACTOR "1"
        EDITOR "nvim"
        TERMINAL "${terminal}"
        XDG_TERMINAL_EMULATOR "${terminal}"
    }
  '';
}
