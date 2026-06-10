{
  host,
  lib,
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
    spawn-at-startup "noctalia-shell"
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
    spawn-at-startup "sh" "-c" "systemctl --user start hyprpolkitagent"
    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "fcitx5" "-d"
    ${noctaliaStartup}${waybarStartup}
  '';
}
