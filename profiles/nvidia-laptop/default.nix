{
  host,
  lib,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) intelID nvidiaID;
in {
  imports = [
    ../../hosts/${host}
    ../../modules/drivers
    ../../modules/core
  ];
  # Enable GPU Drivers
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    intelBusID = "${intelID}";
    nvidiaBusID = "${nvidiaID}";
  };
  drivers.intel.enable = true;
  vm.guest-services.enable = false;

  # Laptop Prime offload: allow the dGPU to power down when idle.
  hardware.nvidia.powerManagement = {
    enable = lib.mkForce true;
    finegrained = lib.mkForce true;
  };
}
