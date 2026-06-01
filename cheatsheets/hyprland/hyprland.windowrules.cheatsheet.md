English | [Español](./hyprland.windowrules.cheatsheet.es.md)

# Hyprland Window Rules — GGOS
## 🧩 Tags and Classification
- file-manager — Thunar, Nautilus, PCManFM-Qt
- terminal — Ghostty, WezTerm, Alacritty, Kitty, kitty-dropterm
- browser — Brave, Firefox, Chrome, Thorium/Cachy
- video — VLC, mpv, Clapper
- projects — VSCodium/VSCode
- im — Discord, WebCord, Vesktop, Ferdium, WhatsApp, Telegram, Teams
- obs — OBS Studio
- games — gamescope, steam_app_*
- gamestore — Steam, Lutris, Heroic
- settings — various settings apps (nm-applet, pavucontrol, file-roller, rofi, etc.)

## 🪟 Floating, Size, and Position
- foot-floating — float, size 60% x 60%, center
- Picture-in-Picture — float, 95%/75% opacity, pinned, keep aspect ratio, position at ~72%/7%
- Authentication Required dialogs — float, center
- Settings-tagged windows — float, size 70% x 70%
- Ferdium — float, center, size 60% x 70%
- Clapper — float
- VSCodium setup dialogs — float (title negative rules)
- Steam/Heroic non-main dialogs — float (title negative rules)
- File chooser dialogs — float; size 70% x 60% (Open Files); float on save prompts

## 🎨 Visual Effects
- noblur — games
- content none — mpv (prevent black screen on maximize)
- Opacity by tag:
  - browser: 1.0 / 1.0
  - video: 1.0 / 1.0
  - projects: 0.9 / 0.8
  - im: 0.94 / 0.86
  - file-manager: 0.9 / 0.8
  - terminal: 1.0 / 0.8
  - settings: 0.8 / 0.7
- Extra opacity tweaks:
  - gedit/GNOME Text Editor/mousepad: 0.8 / 0.7
  - seahorse: 0.9 / 0.8

## 🧭 Workspace Assignment
- im* — workspace 3
- browser* — workspace 2
- obs* — workspace 10

## 🧪 XWayland and Special Cases
- Example targeted xwayland rule: noblur for class “resolve” on xwayland:1

## 🌱 Environment (set via Hyprland)
- NIXOS_OZONE_WL=1, NIXPKGS_ALLOW_UNFREE=1
- XDG_CURRENT_DESKTOP=Hyprland, XDG_SESSION_TYPE=wayland, XDG_SESSION_DESKTOP=Hyprland
- GDK_BACKEND=wayland,x11, CLUTTER_BACKEND=wayland
- QT_QPA_PLATFORM=wayland;xcb, QT_WAYLAND_DISABLE_WINDOWDECORATION=1, QT_AUTO_SCREEN_SCALE_FACTOR=1
- SDL_VIDEODRIVER=x11 (explicit)
- MOZ_ENABLE_WAYLAND=1
- AQ_DRM_DEVICES=/dev/dri/card0:/dev/dri/card1
- GDK_SCALE=1, QT_SCALE_FACTOR=1
- EDITOR=nvim

