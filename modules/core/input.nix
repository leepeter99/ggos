{pkgs, ...}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-nord # a color theme
        qt6Packages.fcitx5-chinese-addons
        qt6Packages.fcitx5-configtool
        fcitx5-gtk
        qt6Packages.fcitx5-with-addons
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

  # Add related packages
  environment.systemPackages = with pkgs; [
    libsForQt5.fcitx5-qt
  ];
}
