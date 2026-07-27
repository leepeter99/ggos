# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

GGOS is a personal NixOS flake configuration (a ZaneyOS derivative) targeting Hyprland/Niri desktops, with per-host settings, GPU hardware profiles, and an integrated Home Manager layer. There is no application code — everything is Nix modules plus shell scripts.

**The repo must live at `~/ggos`** — `modules/core/nh.nix` pins `programs.nh.flake` there, and `zcli`/aliases assume it.

## Common commands

```sh
# Rebuild and switch (preferred; zsh aliases wrap nh)
# Note: fr/fu pass the flake.nix let-bound `profile` (not `host`) as --hostname
fr                      # nh os switch --hostname <profile>
fu                      # same, plus flake input update
zcli rebuild [--dry|--ask|--cores N|--verbose|--no-nom]
zcli update             # rebuild with flake update

# Rebuild for next boot (safer for large changes)
zcli rebuild-boot
sudo nixos-rebuild boot --flake .#<profile>

# Direct, without nh/zcli
sudo nixos-rebuild switch --flake .#<profile>

# Validate the flake (checks structure; does not instantiate or build packages)
nix flake check

# Format Nix files (alejandra is the flake formatter)
nix fmt

# Host management
zcli add-host <hostname> [profile]    # copies hosts/default, can generate hardware.nix
zcli update-host [hostname] [profile] # updates flake.nix let-block; auto-detects GPU if no args
zcli del-host <hostname>

# Diagnostics / maintenance
zcli diag               # writes ~/diag.txt
zcli list-gens          # list system and user generations
zcli cleanup            # prune old generations (interactive)
zcli trim               # fstrim for SSD optimization

# Doom Emacs (two-step: enable in variables.nix → rebuild → install)
zcli doom install       # clones doomemacs and runs doom install
zcli doom status / remove / update

# Other useful aliases
ncg                     # nix-collect-garbage --delete-old (full GC including sudo)
zu                      # pull latest install script from upstream and re-run
```

Profiles (= flake targets): `amd`, `intel`, `nvidia`, `nvidia-laptop` (Intel+NVIDIA hybrid), `amd-nvidia-hybrid`, `vm`. The active host/profile/username for this machine are hardcoded in the `let` block of `flake.nix`
(host `leepeter99`, profile `nvidia-laptop`, username `leepeter99`
 host `helloworld74`, profile `nvidia`, username `helloworld74`.)

When switching to a different machine, run `zcli update-host [hostname] [profile]` (or edit the `let` block in `flake.nix` directly) before rebuilding.

`nix develop` provides a dev shell (`default`) with `nil`, `statix`, `manix`, and `nixfmt-rfc-style`. A `minimal` shell with just `git` and `nixfmt-rfc-style` is available via `nix develop .#minimal`.

## Architecture

Composition chain: `flake.nix` → `profiles/<profile>/default.nix` → imports `hosts/<host>/` + `modules/drivers` + `modules/core` → `modules/core/user.nix` wires in Home Manager → `modules/home/`.

- **`flake.nix`** — declares inputs (nixpkgs unstable, home-manager, stylix, nixvim, nix-flatpak, noctalia, zen-browser, antigravity-nix, …) and builds one `nixosConfiguration` per GPU profile via `mkNixosConfig`. `specialArgs` passes `{ inputs, username, host, profile }` down to every module — many modules take `host` as an argument to import that host's `variables.nix`.

- **`profiles/<profile>/`** — hardware targets only: each toggles the driver options from `modules/drivers` (e.g. `drivers.nvidia-prime.enable` plus Bus IDs read from host variables) and VM guest services.

- **`hosts/<hostname>/`** — per-machine config: `hardware.nix` (generated), `host-packages.nix`, and **`variables.nix`, the primary control surface**. `hosts/default/` is the template that `zcli add-host` copies. Current machines: `helloworld74` and `leepeter99`.

- **`modules/core/`** — system-level NixOS modules (boot, networking, packages, stylix, quickshell, virtualisation, …), composed by its `default.nix`. Display manager is chosen at import time: `ly.nix` when `displayManager = "tui"`, `sddm.nix` otherwise. `quickshell.nix` provides the Qt6 runtime that noctalia-shell needs.

- **`modules/home/`** — the Home Manager layer, composed by its `default.nix`. Subdirectories: `cli/` (bat, btop, fzf, gh, git, lazygit, …), `editors/` (nixvim, helix, vscode, antigravity, doom-emacs), `terminals/` (kitty always-on; alacritty, ghostty, rio, wezterm, tmux conditional), `hyprland/` and `niri/` (each with binds, env, exec-once, windowrules, and many `animations-*.nix` presets), `rofi/`, `scripts/`, `waybar/` (many preset themes), `wlogout/`, `yazi/`. The bar module is selected at import time: `noctalia.nix` when `barChoice = "noctalia"`, otherwise the `waybarChoice` path.

- **`modules/drivers/`** — GPU/VM driver options consumed by profiles (`drivers.amdgpu`, `drivers.intel`, `drivers.nvidia`, `drivers.nvidia-prime`, `vm.guest-services`).

## Key patterns

### `variables.nix` is a plain Nix attribute set

`hosts/<hostname>/variables.nix` returns `{ key = value; }` directly — it is **not** a NixOS module and has no `{ config, pkgs, ... }:` header. Modules import it via `import ../../hosts/${host}/variables.nix`.

### Adding a user-facing toggle

1. Add the key to `hosts/<hostname>/variables.nix`.
2. Add it to the `inherit (vars) ...` block in `modules/home/default.nix`.
3. Use it in the consuming module.

### `waybarChoice` and `animChoice` are Nix paths, not strings

In `variables.nix`, these are Nix path literals pointing to a `.nix` file:
```nix
waybarChoice = ../../modules/home/waybar/waybar-jwt-catppuccin.nix;
animChoice   = ../../modules/home/hyprland/animations-ml4w-classic.nix;
```
To switch themes, uncomment the desired line (only one may be active at a time).

### Adding a new script

1. Create `modules/home/scripts/<name>.nix` returning `pkgs.writeShellScriptBin`.
2. Import it in `modules/home/scripts/default.nix` inside `home.packages = [ ... ]`.

### Stylix theming

`stylixImage` in `variables.nix` drives the entire base16 color palette for all themed apps. To override colors manually, uncomment and edit the `base16Scheme` block in `modules/core/stylix.nix`. Font family and cursor are also configured there.

### Doom Emacs workflow

Set `doomEmacsEnable = true` in `variables.nix`, run `zcli rebuild` (so the Emacs package is installed), then run `zcli doom install` to clone and configure Doom.

Note: `WARP.md` covers the same ground but is partially stale (it predates the switch to nixvim and the alejandra formatter). `zcli.md` has full zcli documentation.
