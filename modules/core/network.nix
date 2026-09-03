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
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [];
    };
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
