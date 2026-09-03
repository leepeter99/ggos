{host, ...}: let
  vars = import ../../../hosts/${host}/variables.nix;
  terminal = vars.terminal or "rio";
in {
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, wayland"
        "MOZ_ENABLE_WAYLAND, 1"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        # Hybrid laptops may need this. Uncomment and order iGPU then dGPU.
        #"AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1:/dev/card2"
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "EDITOR,nvim"
        "TERMINAL,${terminal}"
        "XDG_TERMINAL_EMULATOR,${terminal}"
      ];
    };
  };
}
