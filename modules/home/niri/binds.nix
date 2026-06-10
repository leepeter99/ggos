{
  host,
  lib,
  ...
}: let
  vars = import ../../../hosts/${host}/variables.nix;
  inherit
    (vars)
    barChoice
    browser
    terminal
    ;

  isNoctalia = barChoice == "noctalia";

  noctaliaBinds = lib.optionalString isNoctalia ''
    Mod+D                { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }
    Mod+Shift+Return     { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }
    Mod+M                { spawn "noctalia-shell" "ipc" "call" "notifications" "toggleHistory"; }
    Mod+V                { spawn "noctalia-shell" "ipc" "call" "launcher" "clipboard"; }
    Mod+Alt+P            { spawn "noctalia-shell" "ipc" "call" "settings" "toggle"; }
    Mod+Ctrl+L          { spawn "noctalia-shell" "ipc" "call" "sessionMenu" "lockscreen" "lock"; }
    Mod+Shift+W          { spawn "noctalia-shell" "ipc" "call" "wallpaper" "toggle"; }
    Mod+X                { spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle"; }
    Mod+C                { spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle"; }
    Mod+Ctrl+R           { spawn "noctalia-shell" "ipc" "call" "screenRecorder" "toggle"; }
  '';
  rofiBinds = lib.optionalString (!isNoctalia) ''
    Mod+D                { spawn "rofi-launcher"; }
    Mod+Shift+Return     { spawn "rofi-launcher"; }
    Mod+V                { spawn "sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"; }
  '';
in {
  ggos.niri.configParts.binds = ''
    binds {
        // ============= APPLICATION LAUNCHERS / SHELL =============
    ${noctaliaBinds}${rofiBinds}
        Mod+Return           { spawn "${terminal}"; }
        Mod+W                { spawn "${browser}"; }
        Mod+Alt+K            { spawn "qs-keybinds"; }
        Mod+Alt+Shift+K      { spawn "qs-keybinds"; }
        Mod+Ctrl+C          { spawn "qs-cheatsheets"; }
        Mod+Shift+D          { spawn "discord"; }
        Mod+Alt+W            { spawn "web-search"; }
        Mod+Y                { spawn "kitty" "-e" "yazi"; }
        Mod+T                { spawn "thunar"; }
        Mod+E                { spawn "emopicker9000"; }
        Mod+O                { spawn "obs"; }
        Mod+G                { spawn "gimp"; }
        Mod+Alt+M            { spawn "pavucontrol"; }
        Mod+Alt+C            { spawn "hyprpicker" "-a"; }

        // ============= SCREENSHOTS =============
        Mod+S                { screenshot; }
        Print                { screenshot; }
        Mod+Ctrl+S          { screenshot-screen; }
        Mod+Shift+S          { screenshot-window; }

        // ============= WINDOW MANAGEMENT =============
        Mod+Q                { close-window; }
        Mod+F                { maximize-column; }
        Mod+Shift+F          { fullscreen-window; }
        Mod+Shift+Space      { toggle-window-floating; }
        Mod+P                { switch-focus-between-floating-and-tiling; }
        Mod+R                { switch-preset-column-width; }
        Mod+Shift+R          { reset-window-height; }
        Mod+minus            { set-column-width "-10%"; }
        Mod+equal            { set-column-width "+10%"; }
        Mod+comma            { consume-window-into-column; }
        Mod+period           { expel-window-from-column; }

        // ============= FOCUS MOVEMENT =============
        Mod+Left             { focus-column-left; }
        Mod+Right            { focus-column-right; }
        Mod+Up               { focus-window-up; }
        Mod+Down             { focus-window-down; }
        Mod+h                { focus-column-left; }
        Mod+l                { focus-column-right; }
        Mod+k                { focus-window-up; }
        Mod+j                { focus-window-down; }

        // ============= WINDOW MOVEMENT =============
        Mod+Shift+Left       { move-column-left; }
        Mod+Shift+Right      { move-column-right; }
        Mod+Shift+Up         { move-window-up; }
        Mod+Shift+Down       { move-window-down; }
        Mod+Shift+h          { move-column-left; }
        Mod+Shift+l          { move-column-right; }
        Mod+Shift+k          { move-window-up; }
        Mod+Shift+j          { move-window-down; }

        // ============= WORKSPACES =============
        Mod+1                { focus-workspace 1; }
        Mod+2                { focus-workspace 2; }
        Mod+3                { focus-workspace 3; }
        Mod+4                { focus-workspace 4; }
        Mod+5                { focus-workspace 5; }
        Mod+6                { focus-workspace 6; }
        Mod+7                { focus-workspace 7; }
        Mod+8                { focus-workspace 8; }
        Mod+9                { focus-workspace 9; }
        Mod+Shift+1          { move-column-to-workspace 1; }
        Mod+Shift+2          { move-column-to-workspace 2; }
        Mod+Shift+3          { move-column-to-workspace 3; }
        Mod+Shift+4          { move-column-to-workspace 4; }
        Mod+Shift+5          { move-column-to-workspace 5; }
        Mod+Shift+6          { move-column-to-workspace 6; }
        Mod+Shift+7          { move-column-to-workspace 7; }
        Mod+Shift+8          { move-column-to-workspace 8; }
        Mod+Shift+9          { move-column-to-workspace 9; }
        Mod+Ctrl+Right      { focus-workspace-down; }
        Mod+Ctrl+Left       { focus-workspace-up; }
        Mod+WheelScrollDown  { focus-workspace-down; }
        Mod+WheelScrollUp    { focus-workspace-up; }

        // ============= MEDIA & HARDWARE =============
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute        { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioPlay        { spawn "playerctl" "play-pause"; }
        XF86AudioPause       { spawn "playerctl" "play-pause"; }
        XF86AudioNext        { spawn "playerctl" "next"; }
        XF86AudioPrev        { spawn "playerctl" "previous"; }
        XF86MonBrightnessUp  { spawn "brightnessctl" "set" "+5%"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }

        // ============= SESSION =============
        Mod+Shift+C          { quit; }
    }
  '';
}
