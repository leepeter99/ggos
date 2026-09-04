{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    claude-code
    code-cursor
    codex
    cortex
    libreoffice-fresh
    opencode
    pi-coding-agent
    pwgen
    slack
    spotify
    zoom-us
  ];
  services.flatpak.packages = [];
}
