{host, lib, ...}: let
  vars = import ../../hosts/${host}/variables.nix;
  inherit
    (vars)
    alacrittyEnable
    barChoice
    ghosttyEnable
    rioEnable
    tmuxEnable
    weztermEnable
    vscodeEnable
    helixEnable
    doomEmacsEnable
    antigravityEnable
    ;
  waybarChoice = vars.waybarChoice or ./waybar/waybar-jak-catppuccin-v2.nix;
  barModule =
    if barChoice == "noctalia"
    then ./noctalia.nix
    else waybarChoice;
in {
  imports =
    [
      ./amfora.nix
      ./bash.nix
      ./bashrc-personal.nix
      ./overview.nix
      ./python.nix
      ./cli/bat.nix
      ./cli/btop.nix
      ./cli/bottom.nix
      ./cli/cava.nix
      ./emoji.nix
      ./eza.nix
      ./fastfetch
      ./cli/fzf.nix
      ./cli/gh.nix
      ./cli/git.nix
      ./gtk.nix
      ./cli/htop.nix
      ./hyprland
      ./niri
      ./terminals/kitty.nix
      ./cli/lazygit.nix
      ./obs-studio.nix
      ./editors/nixvim.nix
      ./editors/nano.nix
      ./rofi
      ./qt.nix
      ./scripts
      ./scripts/gemini-cli.nix
      ./stylix.nix
      ./swappy.nix
      ./tealdeer.nix
      ./virtmanager.nix
      barModule
      ./wlogout
      ./xdg.nix
      ./yazi
      ./zen-browser.nix
      ./zoxide.nix
      ./zsh
    ]
    ++ lib.optional (barChoice != "noctalia") ./swaync.nix
    ++ (
      if helixEnable
      then [./editors/evil-helix.nix]
      else []
    )
    ++ (
      if vscodeEnable
      then [./editors/vscode.nix]
      else []
    )
    ++ (
      if antigravityEnable
      then [./editors/antigravity.nix]
      else []
    )
    ++ (
      if doomEmacsEnable
      then [
        ./editors/doom-emacs-install.nix
        ./editors/doom-emacs.nix
      ]
      else []
    )
    ++ (
      if weztermEnable
      then [./terminals/wezterm.nix]
      else []
    )
    ++ (
      if ghosttyEnable
      then [./terminals/ghostty.nix]
      else []
    )
    ++ (
      if tmuxEnable
      then [./terminals/tmux.nix]
      else []
    )
    ++ (
      if alacrittyEnable
      then [./terminals/alacritty.nix]
      else []
    )
    ++ (
      if rioEnable
      then [./terminals/rio.nix]
      else []
    );
}
