{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages =
    [
      # Upstream Claude Code. For the nixpkgs build, comment this, uncomment
      # `claude-code` below, and comment the input in flake.nix.
      # inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
      # Upstream Codex. For the nixpkgs build, comment this, uncomment
      # `codex` below, and comment the input in flake.nix.
      inputs.codex.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ (with pkgs; [
      claude-code
      code-cursor
      # codex # nixpkgs build
      cortex
      opencode
      pi-coding-agent
      pwgen
      slack
      spotify
      zoom-us
    ]);
  services.flatpak.packages = [];
}
