{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages =
    [
      # Upstream Claude Code. For the nixpkgs build, comment this, uncomment
      # `claude-code` below, and comment the input in flake.nix.
      inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ (with pkgs; [
      # claude-code
      code-cursor
      codex
      cortex
      onlyoffice-desktopeditors
      opencode
      pi-coding-agent
      pwgen
      slack
      spotify
      zoom-us
    ]);
  services.flatpak.packages = [];
}
