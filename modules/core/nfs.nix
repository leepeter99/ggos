{host, lib, ...}: let
  inherit (import ../../hosts/${host}/variables.nix) enableNFS;
in {
  boot.supportedFilesystems = lib.mkIf enableNFS ["nfs"];
  services.rpcbind.enable = enableNFS;
}
