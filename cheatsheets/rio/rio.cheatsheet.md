# Rio on GGOS — Summary & Cheatsheet
## 🚀 Summary of modules/home/terminals/rio.nix

- Program
  - Rio enabled via `programs.rio` (home-manager)
  - Config written to `~/.config/rio/config.toml`

- Appearance
  - Font: Maple Mono NF, size 12 (overrides stylix terminal font)
  - Cursor: beam, blinking
  - Background opacity: 0.70
  - Blur: off
  - Window decorations: Disabled (niri owns corner radius / clip + prefer-no-csd)

- Navigation
  - Tab mode (Rio's default tab navigation)

---

## 🗝️ Keybindings Cheatsheet

Session
- Super+Q — Quit (exit Rio)

Notes
- `Super` is the `Mod` key in niri. `Super+Q` mirrors niri's `Mod+Q { close-window; }`
  so closing a terminal feels the same as closing any other window.
- Built-in Rio bindings (copy/paste, font size, tab/split nav) remain active; only
  the explicit `Quit` binding is overridden here.

---

## ⚙️ Default Options Reference (as configured)

Fonts
- fonts.family: Maple Mono NF
- fonts.size: 12

Cursor
- cursor.shape: beam
- cursor.blinking: true

Window
- window.opacity: 0.70
- window.opacity-cells: true
- window.blur: false
- window.decorations: Disabled

Navigation
- navigation.mode: Tab

Bindings
- { key = "q", with = "super", action = "Quit" }

---

## 📝 Notes

Rio uses a TOML config (`config.toml`). Some font/feature changes require a full
restart of Rio to take effect (no live reload). Docs: https://rioterm.com/docs/config
