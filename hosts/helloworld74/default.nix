{...}: {
  imports = [
    ./hardware.nix
    ./host-packages.nix
  ];
  boot.kernelModules = ["kvm-amd"];
}
