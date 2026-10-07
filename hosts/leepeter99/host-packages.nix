{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages =
    [
      # To track upstream, uncomment this entry and the input in flake.nix,
      # then comment out `claude-code` below.
      # inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ (with pkgs; [
      claude-code
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
