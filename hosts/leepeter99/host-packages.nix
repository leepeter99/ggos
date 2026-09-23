{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
  ];
  services.flatpak.packages = [];
}
