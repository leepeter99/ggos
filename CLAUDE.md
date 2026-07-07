# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

GGOS is a personal NixOS flake configuration (a ZaneyOS derivative) targeting Hyprland/Niri desktops, with per-host settings, GPU hardware profiles, and an integrated Home Manager layer. There is no application code — everything is Nix modules plus shell scripts.

**The repo must live at `~/ggos`** — `modules/core/nh.nix` pins `programs.nh.flake` there, and `zcli`/aliases assume it.

## Common commands

```sh
# Rebuild and switch (preferred; zsh aliases wrap nh)
fr                      # nh os switch --hostname <profile>
fu                      # same, plus flake input update
zcli rebuild [--dry|--ask|--cores N|--verbose|--no-nom]
zcli update             # rebuild with flake update

# Rebuild for next boot (safer for large changes)
zcli rebuild-boot
sudo nixos-rebuild boot --flake .#<profile>

# Direct, without nh/zcli
sudo nixos-rebuild switch --flake .#<profile>

# Validate the flake (this is the "test suite" — run after changes)
nix flake check

# Format Nix files (alejandra is the flake formatter)
nix fmt

# Host management
zcli add-host <hostname> [profile]    # copies hosts/default, can generate hardware.nix
zcli update-host [hostname] [profile]
zcli del-host <hostname>

# Diagnostics / maintenance
zcli diag               # writes ~/diag.txt
zcli cleanup            # prune old generations (interactive)
```

Profiles (= flake targets): `amd`, `intel`, `nvidia`, `nvidia-laptop` (Intel+NVIDIA hybrid), `amd-nvidia-hybrid`, `vm`. The active host/profile/username for this machine are hardcoded in the `let` block of `flake.nix` (currently host `leepeter99`, profile `nvidia-laptop`).

`nix develop` provides a dev shell with `nil`, `statix`, `manix`, and `nixfmt-rfc-style`.

## Architecture

Composition chain: `flake.nix` → `profiles/<profile>/default.nix` → imports `hosts/<host>/` + `modules/drivers` + `modules/core` → `modules/core/user.nix` wires in Home Manager → `modules/home/`.

- **`flake.nix`** — declares inputs (nixpkgs unstable, home-manager, stylix, nixvim, nix-flatpak, noctalia, zen-browser, antigravity-nix, …) and builds one `nixosConfiguration` per GPU profile via `mkNixosConfig`. `specialArgs` passes `{ inputs, username, host, profile }` down to every module — many modules take `host` as an argument to import that host's `variables.nix`.

- **`profiles/<profile>/`** — hardware targets only: each toggles the driver options from `modules/drivers` (e.g. `drivers.nvidia-prime.enable` plus Bus IDs read from host variables) and VM guest services.

- **`hosts/<hostname>/`** — per-machine config: `hardware.nix` (generated), `host-packages.nix`, and **`variables.nix`, the primary control surface**. Feature toggles live there: `barChoice` (`"noctalia"` or `"waybar"`), display manager (`tui`/sddm), terminal/editor enables (`rioEnable`, `vscodeEnable`, `helixEnable`, `doomEmacsEnable`, …), monitor layouts for both Hyprland (`extraMonitorSettings`) and Niri (`niriOutputs`), default browser, GPU Bus IDs. When adding a user-facing option, thread it through `variables.nix` → consuming module, following the existing `inherit (vars) ...` pattern in `modules/home/default.nix`.

- **`modules/core/`** — system-level NixOS modules (boot, networking, greetd/sddm/ly, packages, stylix, quickshell, virtualisation, …), composed by its `default.nix`. `quickshell.nix` provides the Qt6 runtime that noctalia-shell needs.

- **`modules/home/`** — the Home Manager layer (Hyprland, Niri, terminals, zsh, nixvim, rofi, scripts, …). Its `default.nix` conditionally imports the bar module: `noctalia.nix` when `barChoice = "noctalia"`, otherwise the `waybarChoice` path. `scripts/` installs `zcli`. The `fr`/`fu` aliases are defined in `modules/home/zsh/default.nix`, parameterized by the active profile.

- **`modules/drivers/`** — GPU/VM driver options consumed by profiles (`drivers.amdgpu`, `drivers.intel`, `drivers.nvidia`, `drivers.nvidia-prime`, `vm.guest-services`).

Note: `WARP.md` covers the same ground but is partially stale (it predates the switch to nixvim and the alejandra formatter). `zcli.md` has full zcli documentation.
