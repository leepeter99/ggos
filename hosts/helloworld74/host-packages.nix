{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    claude-code
    code-cursor
    codex
    libreoffice-fresh
    opencode
    postman
    pwgen
    slack
    spotify
    zoom-us
  ];
  services.flatpak.packages = [];
}
