# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

Project: GGOS — NixOS flake for desktop systems with per-host overrides, GPU/VM profiles, and an integrated Home Manager layer.

## Important repo expectations
- This repo is expected at: `~/ggos` (`programs.nh.flake` points here). If you keep it elsewhere, update `modules/core/nh.nix` accordingly.
- Target OS: NixOS 23.11+ / Unstable; UEFI + GPT expected; systemd-boot / GRUB supported out of the box.

## Branch Overview & Current Status

### `lua` Branch (Current Active Desktop Branch)
- **Architecture**: Profile-centric flake configurations (`mkNixosConfig gpuProfile`).
  - Hardware profiles: `.#amd`, `.#intel`, `.#nvidia`, `.#nvidia-laptop`, `.#amd-nvidia-hybrid`, `.#vm`.
  - Top-level `host` and `profile` variables in `flake.nix` are injected via `specialArgs`.
  - Each profile in `profiles/<profile>/default.nix` imports `../../hosts/${host}`, `../../modules/drivers`, and `../../modules/core`.
- **Yazi Configuration**:
  - Pure TOML & Lua file structure managed via `xdg.configFile` in `modules/home/yazi/default.nix`.
  - Config files: `yazi.toml`, `keymap.toml`, `theme.toml`, `init.lua`, `package.toml`.
  - Flavors: `catppuccin-macchiato.yazi`.
  - Plugins: `compress.yazi`, `full-border.yazi`, `git.yazi`, `smart-filter.yazi`, `yatline.yazi`, `yatline-githead.yazi`.
- **Polkit & Security Fixes**:
  - `modules/core/security.nix`: `security.polkit.enablePkexecWrapper = true;` enables the official NixOS setuid root wrapper (`/run/wrappers/bin/pkexec`).
  - `modules/core/user.nix`: `programs.zsh.enable = true;` registered at system level to add `zsh` into `/etc/shells`, preventing PAM `pkexec` authentication failures.
  - `modules/home/stylix.nix`: `stylix.targets.yazi.enable = false;` to prevent Stylix theme generation collisions with custom `theme.toml`.
- **Core Overlays**:
  - `modules/core/overlays.nix`: Includes `dwarfs` 0.14.0 hotfix for GCC `<cstring>` (`#include <cstring>` in `folly/folly/lang/Exception.h`) with `fmt_11` and `-DENABLE_WERROR=OFF` needed by `gearlever`.

### `zos-next` Branch (Next-Gen Architecture Branch)
- **Architecture**: Host-centric modular configuration structure.
  - Targets hosts directly (`mkNixosConfig host`) via `hosts = [ "ggos-next" "default" "ggos-24-vm" "ggos-oem" ]`.
  - Flake outputs generate `nixosConfigurations.<host>` using `builtins.listToAttrs`.
  - Stacks `./modules/core/overlays.nix`, `./modules/core`, `./modules/drivers`, `./hosts/${host}`, and `./profiles`.
- **Parity with `lua`**:
  - Yazi configuration updated to the modular `xdg.configFile` TOML/Lua/plugins structure (matching `lua` and `ddubsos`).
  - Dwarfs / Gearlever overlay incorporated in `modules/core/overlays.nix`.
  - Polkit `enablePkexecWrapper = true` and system-level `programs.zsh.enable = true` applied.
  - Stylix Yazi target disabled (`stylix.targets.yazi.enable = false`).

## Common commands
- **Rebuild and switch (preferred via nh/zcli)**:
  - `fr`            # zsh alias → `nh os switch --hostname <profile>`
  - `fu`            # zsh alias → `nh os switch --hostname <profile> --update`
  - `zcli rebuild [--dry|--ask|--cores N|--verbose|--no-nom]`
  - `zcli update  [--dry|--ask|--cores N|--verbose|--no-nom]`
- **Rebuild for next boot (safer for bigger changes)**:
  - `zcli rebuild-boot [same options]`
  - `sudo nixos-rebuild boot --flake .#<profile>`
- **Direct NixOS (without nh/zcli)**:
  - `sudo nixos-rebuild switch --flake .#<profile>`
- **Validate the flake**:
  - `nix flake check`
- **Host management (`zcli`)**:
  - `zcli update-host [hostname] [profile]`  # auto-detect if args omitted
  - `zcli add-host <hostname> [profile]`     # copies hosts/default, can gen hardware.nix
  - `zcli del-host <hostname>`
- **Diagnostics and maintenance**:
  - `zcli diag`           # writes `~/diag.txt`
  - `zcli cleanup`        # prunes generations (interactive)
  - `zcli trim`           # runs fstrim with confirmation

## High-level architecture (big picture)
- **`flake.nix`**:
  - Inputs: `nixpkgs` (unstable), `home-manager`, `stylix`, `nvf`, `nix-flatpak`, `noctalia`, `nixvim`, `zen-browser`, `synfetch`.
  - Defines system, host, profile, username; constructs `nixosConfigurations`.
- **`profiles/<profile>/default.nix`**:
  - Toggles drivers and VM guest services per profile; `nvidia-laptop` and `amd-hybrid` profiles consume Bus IDs from host variables.
- **`hosts/<hostname>/`**:
  - `default.nix` imports `hardware.nix` and `host-packages.nix`.
  - `variables.nix` is the primary control surface (display manager, terminal/browser defaults, waybarChoice, stylix image, 24h clock, Thunar/printing/NFS flags, Bus IDs, etc.).
- **`modules/core`**:
  - Composes system modules: boot, flatpak, fonts, hardware, network, nfs, nh, quickshell, overlays, packages, printing, display manager (Ly/SDDM), security (polkit + wrappers), services (PipeWire/SSH/Bluetooth/fstrim), steam, stylix, syncthing, system, thunar, user (Home Manager), virtualization, xserver.
- **`modules/drivers`**:
  - AMD, Intel, NVIDIA, NVIDIA Prime, NVIDIA AMD-Hybrid, and VM guest services.
- **`modules/home`**:
  - Composes user environment: Hyprland, bar/shell choice (Noctalia-shell or Waybar), Rofi, Yazi, terminals (Kitty/WezTerm/Ghostty/Alacritty toggles), Zsh/Bash config, Git, NVF/Neovim, OBS, swaync, scripts (`zcli`, keybinds-parser, cheatsheets-parser), Stylix, optional Doom Emacs/VSCodium/Helix.

## Key development choices
- **Repo location**: `nh` and `zcli` assume `~/ggos`; if located elsewhere, adjust `modules/core/nh.nix`.
- **Validation**: Validate changes with `nix flake check` or `nix eval`.
- **Setuid & Polkit**: Use `security.polkit.enablePkexecWrapper = true` for `pkexec` setuid wrapping, and ensure `programs.zsh.enable = true` is present at system level when user login shell is Zsh.
- **Theme Isolation**: Disable Stylix target for modules using dedicated custom themes (`stylix.targets.yazi.enable = false`).