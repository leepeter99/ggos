English | [Español](./yazi.keymap.cheatsheet.es.md)

# Yazi Keymap — GGOS (Human-friendly)
## 🧭 Navigation
- k / Up — Move up
- j / Down — Move down
- Ctrl+u / Shift+PageUp — Half page up
- Ctrl+d / Shift+PageDown — Half page down
- Ctrl+b / PageUp — Page up
- Ctrl+f / PageDown — Page down
- g g — Go to top
- G — Go to bottom
- h / Left — Go to parent directory
- l / Right — Enter child directory
- H — Back (previous directory)
- L — Forward (next directory)

## 🧰 Selection & Visual Mode
- Space — Toggle current, then move down
- Ctrl+a — Select all
- Ctrl+r — Invert selection
- v — Enter visual (select) mode
- V — Visual unset mode

## 🔎 Search & Filter
- s — Search by name (fd)
- S — Search by content (ripgrep)
- Ctrl+s — Cancel search
- f — Filter files (smart)
- / — Find next (smart)
- ? — Find previous (smart)
- n — Next found
- N — Previous found

## 📂 Open & Preview
- o / Enter — Open
- O / Shift+Enter — Open interactively
- Tab — Spot hovered file
- K / J — Seek up/down in preview (±5)

## 📋 Clipboard (Yank/Copy/Move)
- y — Yank (copy)
- x — Yank cut (move)
- p — Paste
- P — Paste (overwrite)
- - — Symlink absolute path of yanked
- _ — Symlink relative path of yanked
- Ctrl+- — Hardlink yanked
- Y / X — Unyank (cancel yank)

## 🗑️ Delete
- d — Trash selected
- D — Delete permanently

## ✏️ Create & Rename
- a — Create file/dir (use trailing / for folders)
- r — Rename (cursor before extension)

## 🖥️ Shell
- ; — Run shell command (interactive)
- : — Run shell command (block until done)

## 👀 Hidden Files
- . — Toggle hidden

## 🧭 Quick Jumps
- g h — Go to $HOME
- g c — Go to ~/.config
- g d — Go to ~/Downloads
- g Space — Jump interactively
- z — Zoxide jump
- Z — FZF jump (file/dir)

## 🧾 Linemode (Metadata View)
- m s — Size
- m p — Permissions
- m b — Birth time
- m m — Modified time
- m o — Owner
- m n — None

## 🔤 Sorting
- , m / , M — Sort by mtime (asc/desc)
- , b / , B — Sort by btime (asc/desc)
- , e / , E — Sort by extension (asc/desc)
- , a / , A — Sort alphabetically (asc/desc)
- , n / , N — Sort naturally (asc/desc)
- , s / , S — Sort by size (asc/desc)
- , r — Sort randomly

## 🗂️ Tabs
- t — New tab (current dir)
- 1..9 — Switch to tab 1..9
- [ / ] — Previous / Next tab
- { / } — Swap tab left / right

## 🧮 Tasks & Help
- w — Show tasks (task manager)
- ~ / F1 — Open help

## 🧩 Plugins (Prepend)
- g i — LazyGit (plugin)
- l — Smart enter (dir enter or open file)

## 🧰 Spot, Pick, Input, Confirm, Completion (Modes)
- Spot mode: Esc/C-[/Ctrl+c/Tab to close; k/j/Up/Down navigate; h/l or Left/Right to swipe; c c copy cell; ~ / F1 for help
- Pick mode: Esc/C-[/Ctrl+c to cancel; Enter to submit; k/j/Up/Down navigate; ~ / F1 help
- Input mode: Esc/C-[ to escape; i/I/a/A enter insert/append (with BOL/EOL moves); visual selections (v, V, Ctrl-A/E); movement (h/l/Left/Right/C-b/C-f/b/B/w/W/e/E/Alt-b/Alt-f); delete/backspace/kill words; cut/copy/paste (d/D/c/C/x/y/p/P); undo/redo (u/C-r); ~ / F1 help
- Confirm mode: Esc/C-[/Ctrl+c/n to cancel; Enter/y to submit; k/j/Up/Down navigate; ~ / F1 help
- Completion mode: Ctrl+c cancel; Tab submit; Enter submit completion + input; Alt-k/j or Up/Down/C-p/C-n navigate; ~ / F1 help

