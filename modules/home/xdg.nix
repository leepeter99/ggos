{pkgs, host, ...}: let
  vars = import ../../hosts/${host}/variables.nix;
in {
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        {
          "x-scheme-handler/http" = ["${vars.browser}.desktop"];
          "x-scheme-handler/https" = ["${vars.browser}.desktop"];
          "text/html" = ["${vars.browser}.desktop"];
        }
        // (vars.mimeDefaultApps or {});

      # Example: set default handlers for MIME types and URL schemes.
      # Uncomment the block below and adjust .desktop IDs to your preferred apps.
      # defaultApplications = {
      #   # PDFs
      #   "application/pdf" = ["okular.desktop"];      # change to your preferred reader
      #   "application/x-pdf" = ["okular.desktop"];    # legacy alias
      #
      #   # Web browser
      #   "x-scheme-handler/http"  = ["google-chrome.desktop"];  # or brave-browser.desktop, firefox.desktop, etc.
      #   "x-scheme-handler/https" = ["google-chrome.desktop"];
      #   "text/html"              = ["google-chrome.desktop"];
      #
      #   # Text files
      #   "text/plain" = ["nvim.desktop"];             # or code.desktop, org.gnome.TextEditor.desktop
      #
      #   # Images and video
      #   "image/png" = ["imv.desktop"];               # or org.gnome.eog.desktop
      #   "video/mp4" = ["mpv.desktop"];               # or vlc.desktop
      #
      #   # Archives
      #   "application/zip" = ["org.gnome.FileRoller.desktop"]; # or xarchiver.desktop, peazip.desktop
      #
      #   # Folders (file manager)
      #   "inode/directory" = ["thunar.desktop"];      # or org.gnome.Nautilus.desktop, org.kde.dolphin.desktop
      # };
    };
    portal = {
      enable = true;
      # HM's portal module sets XDG_DESKTOP_PORTAL_DIR to its own dir, hiding
      # the system-level portals from programs.niri.enable. Niri needs the
      # gnome portal for ScreenCast (it speaks the Mutter screencast API) and
      # gtk as general fallback, so they must be listed here too.
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
      # pkgs.niri ships niri-portals.conf (per-desktop backend selection)
      configPackages = [pkgs.hyprland pkgs.niri];
    };
  };
}
