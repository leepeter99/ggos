# Herdr is an agent multiplexer: a client/server terminal session manager
# (tmux-like) built for running coding agents such as Claude Code.
# Docs: https://herdr.dev/docs/
{pkgs, ...}: {
  home.packages = [pkgs.herdr];

  xdg.configFile."herdr/config.toml".text = ''
    onboarding = false

    [keys]
    # Same prefix as the tmux config in this repo
    prefix = "ctrl+a"

    [terminal]
    default_shell = "${pkgs.zsh}/bin/zsh"
  '';
}
