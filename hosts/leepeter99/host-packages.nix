{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages =
    [
      # TEMPORARY: Claude Code from the upstream flake (github:sadjow/claude-code-nix)
      # instead of nixpkgs, which lags behind. To revert: delete this entry, the
      # `claude-code` input in flake.nix, and uncomment `claude-code` below.
      inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ (with pkgs; [
      # claude-code # temporarily sourced from the upstream flake above
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
