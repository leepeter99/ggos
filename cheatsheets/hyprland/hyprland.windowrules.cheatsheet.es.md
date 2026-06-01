[English](./hyprland.windowrules.cheatsheet.md) | Español

# Reglas de Ventana de Hyprland — GGOS
## 🧩 Etiquetas y Clasificación
- file-manager — Thunar, Nautilus, PCManFM-Qt
- terminal — Ghostty, WezTerm, Alacritty, Kitty, kitty-dropterm
- browser — Brave, Firefox, Chrome, Thorium/Cachy
- video — VLC, mpv, Clapper
- projects — VSCodium/VSCode
- im — Discord, WebCord, Vesktop, Ferdium, WhatsApp, Telegram, Teams
- obs — OBS Studio
- games — gamescope, steam_app_*
- gamestore — Steam, Lutris, Heroic
- settings — varias aplicaciones de configuración (nm-applet, pavucontrol, file-roller, rofi, etc.)

## 🪟 Flotante, Tamaño y Posición
- foot-floating — flotante, tamaño 60% x 60%, centrado
- Picture-in-Picture — flotante, opacidad 95%/75%, fijado, mantener relación de aspecto, posición en ~72%/7%
- Diálogos de Autenticación Requerida — flotante, centrado
- Ventanas etiquetadas como Settings — flotante, tamaño 70% x 70%
- Ferdium — flotante, centrado, tamaño 60% x 70%
- Clapper — flotante
- Diálogos de configuración de VSCodium — flotante (reglas negativas de título)
- Diálogos no principales de Steam/Heroic — flotante (reglas negativas de título)
- Diálogos de selección de archivos — flotante; tamaño 70% x 60% (Abrir Archivos); flotante en avisos de guardado

## 🎨 Efectos Visuales
- noblur — juegos
- content none — mpv (prevenir pantalla negra al maximizar)
- Opacidad por etiqueta:
  - browser: 1.0 / 1.0
  - video: 1.0 / 1.0
  - projects: 0.9 / 0.8
  - im: 0.94 / 0.86
  - file-manager: 0.9 / 0.8
  - terminal: 1.0 / 0.8
  - settings: 0.8 / 0.7
- Ajustes de opacidad adicionales:
  - gedit/GNOME Text Editor/mousepad: 0.8 / 0.7
  - seahorse: 0.9 / 0.8

## 🧭 Asignación de Espacio de Trabajo
- im* — espacio de trabajo 3
- browser* — espacio de trabajo 2
- obs* — espacio de trabajo 10

## 🧪 XWayland y Casos Especiales
- Ejemplo de regla específica para xwayland: noblur para la clase “resolve” en xwayland:1

## 🌱 Entorno (establecido a través de Hyprland)
- NIXOS_OZONE_WL=1, NIXPKGS_ALLOW_UNFREE=1
- XDG_CURRENT_DESKTOP=Hyprland, XDG_SESSION_TYPE=wayland, XDG_SESSION_DESKTOP=Hyprland
- GDK_BACKEND=wayland,x11, CLUTTER_BACKEND=wayland
- QT_QPA_PLATFORM=wayland;xcb, QT_WAYLAND_DISABLE_WINDOWDECORATION=1, QT_AUTO_SCREEN_SCALE_FACTOR=1
- SDL_VIDEODRIVER=x11 (explícito)
- MOZ_ENABLE_WAYLAND=1
- AQ_DRM_DEVICES=/dev/dri/card0:/dev/dri/card1
- GDK_SCALE=1, QT_SCALE_FACTOR=1
- EDITOR=nvim
