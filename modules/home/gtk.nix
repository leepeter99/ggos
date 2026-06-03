{
  config,
  pkgs,
  lib,
  ...
}: {
  gtk = {
    # Newer Stylix manages gtk4.theme; force-null keeps gtk4 unthemed (prior behavior).
    # Delete this mkForce line instead if you want Stylix to theme gtk4 apps too.
    gtk4.theme = lib.mkForce null;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
