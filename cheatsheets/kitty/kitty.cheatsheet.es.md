[English](./kitty.cheatsheet.md) | Español

# Kitty en GGOS — Resumen y Cheatsheet
## 🚀 Resumen de modules/home/terminals/kitty.nix

- Programa
  - Kitty habilitado con el paquete pkgs.kitty
  - Integraciones de shell: Zsh, Fish, Bash (modo: habilitado)

- Apariencia y Comportamiento
  - Fuente: Maple Mono NF, tamaño 12
  - Historial de desplazamiento: 10,000 líneas; líneas mínimas de la rueda: 1; relleno: 4px
  - Confirmar cierre: 0 (sin confirmar); campana de audio: deshabilitada; espera para ocultar el ratón: 60
  - Rastro del cursor: 1; desvanecimiento de pestaña: 1; estilo de fuente de pestaña activa/inactiva: negrita
  - Barra de pestañas: superior, estilo powerline
  - Diseños: divisiones habilitadas
  - Manejo de URL: abrir con el predeterminado; detectar URL: true; allow_remote_control: true

- Tema (configuración manual de Catppuccin Mocha en extraConfig)
  - Primer plano/fondo, selección, cursor, bordes, barra de pestañas y paleta de 16 colores establecidos explícitamente

---

## 🗝️ Cheatsheet de Atajos de Teclado (extraConfig)

Portapapeles
- Ctrl+Shift+V — paste_from_selection
- Shift+Insert — paste_from_selection

Historial de desplazamiento
- Ctrl+Shift+Arriba / k — scroll_line_up
- Ctrl+Shift+Abajo / j — scroll_line_down
- Ctrl+Shift+RePág — scroll_page_up
- Ctrl+Shift+AvPág — scroll_page_down
- Ctrl+Shift+Inicio — scroll_home
- Ctrl+Shift+Fin — scroll_end
- Ctrl+Shift+H — show_scrollback

Ventanas/Pestañas/Diseño
- Alt+N — new_window_with_cwd
- Alt+W — close_window
- Ctrl+Shift+Enter — dividir horizontalmente (hsplit)
- Ctrl+Shift+S — dividir verticalmente (vsplit)
- Ctrl+Shift+] / [ — next_window / previous_window
- Ctrl+Shift+F — move_window_forward
- Ctrl+Shift+B — move_window_backward
- Ctrl+Shift+` — move_window_to_top
- Ctrl+Shift+1..0 — first..tenth_window
- Ctrl+Shift+Derecha/Izquierda — next_tab / previous_tab
- Ctrl+Shift+T — new_tab
- Ctrl+Shift+Q — close_tab
- Ctrl+Shift+L — next_layout
- Ctrl+Shift+. / , — move_tab_forward / move_tab_backward

Tamaño de Fuente
- Ctrl+Shift+Arriba — increase_font_size
- Ctrl+Shift+Abajo — decrease_font_size
- Ctrl+Shift+Retroceso — restore_font_size

Notas
- El esquema de colores está incrustado; el soporte de Stylix está deshabilitado en esta configuración.
