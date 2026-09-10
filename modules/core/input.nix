{pkgs, ...}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      # NixOS's wrapper includes the config tool and GTK/Qt 5/6 integration.
      addons = with pkgs; [
        fcitx5-nord # a color theme
        (fcitx5-rime.override {rimeDataPkgs = [rime-ice];})
      ];
      # Enable Wayland frontend for better Hyprland compatibility
      waylandFrontend = true;
    };
  };

  # Wayland frontend: do not set GTK_IM_MODULE / QT_IM_MODULE (they fight native IM).
  environment.variables = {
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
}
