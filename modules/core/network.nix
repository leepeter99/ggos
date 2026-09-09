{
  pkgs,
  host,
  options,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) hostId;
in {
  networking = {
    hostName = "${host}";
    hostId = hostId;
    networkmanager = {
      enable = true;
      # Don't let NM clobber resolv.conf; systemd-resolved owns it so Tailscale
      # can do split-DNS (ts.net only) instead of hijacking every lookup.
      dns = "systemd-resolved";
    };
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        587
        3000
        59010
        59011
        8080
      ];
      allowedUDPPorts = [
        500
        4500
        59010
        59011
      ];
    };
  };

  # Without this, Tailscale rewrites resolv.conf to 100.100.100.100 and some
  # public names fail. With it, MagicDNS stays on *.ts.net only.
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    dnssec = "allow-downgrade";
    fallbackDns = ["1.1.1.1" "1.0.0.1" "8.8.8.8"];
    extraConfig = ''
      DNS=1.1.1.1 1.0.0.1
    '';
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
