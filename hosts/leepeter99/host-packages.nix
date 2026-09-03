{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    claude-code
    code-cursor
    codex
    libreoffice-fresh
    opencode
    pwgen
    slack
    spotify
    zoom-us
  ];
  services.flatpak.packages = [];
}
