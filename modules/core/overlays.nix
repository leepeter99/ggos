{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      cortex = final.callPackage ../../pkgs/cortex {};
    })
  ];
}
