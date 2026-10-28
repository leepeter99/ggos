# Eza is a ls replacement
{
  programs.eza = {
    enable = true;
    icons = "always";
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--header" # Show header row
      "--git-ignore"
      # "--time-style=long-iso" # ISO 8601 extended format for time
      "--classify" # append indicator (/, *, =, @, |)
      "--hyperlink=auto" # make paths clickable; bare --hyperlink swallows the next arg (e.g. `ls dir`)
    ];
  };
  # Aliases to make `ls`, `ll`, `la` use eza
  home.shellAliases = {
    ls = "eza";
    lt = "eza --tree --level=2";
    ll = "eza  -lh --no-user --long";
    la = "eza -lah ";
    tree = "eza --tree ";
  };
}
