{
  host,
  lib,
  pkgs,
  ...
}: let
  vars = import ../../../hosts/${host}/variables.nix;
  inherit
    (vars)
    barChoice
    stylixImage
    ;

  isNoctalia = barChoice == "noctalia";

  noctaliaStartup = lib.optionalString isNoctalia ''
    spawn-at-startup "sh" "-lc" "systemctl --user start noctalia.service || true"
  '';
  waybarStartup = lib.optionalString (!isNoctalia) ''
    spawn-at-startup "sh" "-c" "killall -q awww; sleep .5 && awww-daemon"
    spawn-at-startup "sh" "-c" "killall -q waybar; sleep .5 && waybar"
    spawn-at-startup "sh" "-c" "killall -q swaync; sleep .5 && swaync"
    spawn-at-startup "nm-applet" "--indicator"
    spawn-at-startup "sh" "-lc" "sleep 2 && (qs-wallpapers-restore || waypaper --wallpaper \"${stylixImage}\" --backend awww) >/dev/null 2>&1 || true"
  '';
in {
  ggos.niri.configParts.startup = ''
    // Startup
    spawn-at-startup "sh" "-c" "wl-paste --type text --watch cliphist store"
    spawn-at-startup "sh" "-c" "wl-paste --type image --watch cliphist store"
    spawn-at-startup "sh" "-c" "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    spawn-at-startup "sh" "-c" "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    spawn-at-startup "sh" "-c" "systemctl --user start hyprpolkitagent"
    spawn-at-startup "qs" "-c" "overview"
    spawn-at-startup "fcitx5" "-d"
    spawn-at-startup "sh" "-lc" "${pkgs.swayidle}/bin/swayidle -w timeout 900 '${pkgs.hyprlock}/bin/hyprlock' timeout 1200 '${pkgs.niri}/bin/niri msg action power-off-monitors' resume '${pkgs.niri}/bin/niri msg action power-on-monitors'"
    ${noctaliaStartup}${waybarStartup}
  '';
}
