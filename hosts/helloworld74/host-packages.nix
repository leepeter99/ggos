{
  configs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    claude-code
    code-cursor
    codex
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

  services.auto-cpufreq.enable = false;
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
