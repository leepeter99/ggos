{
  configs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    claude-code
    code-cursor
    codex
    libreoffice-fresh
    opencode
    postman
    pwgen
    spotify
    zoom-us
  ];
  # Add host specific flatpaks here
  services = {
    flatpak = {
      packages = [
      ];
    };
  };

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
