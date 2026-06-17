{
  pkgs,
  inputs,
  ...
}: let
  # Prefer explicit package name if available; fall back to default
  zenPkg = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser or inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  zenSingle = pkgs.writeShellScriptBin "zen-browser-single" ''
    set -euo pipefail

    lock_file="''${XDG_RUNTIME_DIR:-/tmp}/zen-browser-single.lock"
    user_id="$(${pkgs.coreutils}/bin/id -u)"

    zen_running() {
      ${pkgs.procps}/bin/pgrep -u "$user_id" -f '[z]en-beta' >/dev/null 2>&1
    }

    focus_hyprland() {
      [ -n "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ] || return 1

      local address
      address="$(
        ${pkgs.hyprland}/bin/hyprctl clients -j 2>/dev/null \
          | ${pkgs.jq}/bin/jq -r '
              map(select(
                ((.class // "") | test("(?i)^zen-beta$")) or
                ((.initialClass // "") | test("(?i)^zen-beta$"))
              ))
              | first
              | .address // empty
            '
      )" || return 1

      [ -n "$address" ] || return 1
      ${pkgs.hyprland}/bin/hyprctl dispatch focuswindow "address:$address" >/dev/null 2>&1
    }

    focus_niri() {
      [ -n "''${NIRI_SOCKET:-}" ] || return 1

      local window_id
      window_id="$(
        ${pkgs.niri}/bin/niri msg -j windows 2>/dev/null \
          | ${pkgs.jq}/bin/jq -r '
              map(select((.app_id // "") | test("(?i)^zen-beta$")))
              | first
              | .id // empty
            '
      )" || return 1

      [ -n "$window_id" ] || return 1
      ${pkgs.niri}/bin/niri msg action focus-window --id "$window_id" >/dev/null 2>&1
    }

    focus_existing() {
      focus_hyprland || focus_niri
    }

    if [ "$#" -eq 0 ] && { focus_existing || zen_running; }; then
      exit 0
    fi

    (
      ${pkgs.util-linux}/bin/flock -n 9 || exit 0

      if [ "$#" -eq 0 ] && { focus_existing || zen_running; }; then
        exit 0
      fi

      ${zenPkg}/bin/zen-beta "$@" >/dev/null 2>&1 &

      for _ in $(${pkgs.coreutils}/bin/seq 1 50); do
        focus_existing && exit 0
        ${pkgs.coreutils}/bin/sleep 0.1
      done
    ) 9>"$lock_file"
  '';
in {
  # Install Zen Browser for the user
  home.packages = [
    zenPkg
    zenSingle
  ];

  xdg.desktopEntries.zen-beta = {
    name = "Zen Browser (Beta)";
    genericName = "Web Browser";
    exec = "zen-browser-single %U";
    icon = "zen-browser";
    terminal = false;
    type = "Application";
    categories = ["Network" "WebBrowser"];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "application/vnd.mozilla.xul+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
    startupNotify = true;
    settings.StartupWMClass = "zen-beta";
    actions = {
      new-private-window = {
        name = "New Private Window";
        exec = "zen-beta --private-window %U";
      };
      new-window = {
        name = "New Window";
        exec = "zen-beta --new-window %U";
      };
      profile-manager-window = {
        name = "Profile Manager";
        exec = "zen-beta --ProfileManager";
      };
    };
  };
}
