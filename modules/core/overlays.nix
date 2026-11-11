{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      cortex = final.callPackage ../../pkgs/cortex {};
      # ponytail: upstream nixpkgs node_modules FOD hash is stale for 2.2.5; drop once nixpkgs fixes it
      opencode = prev.opencode.overrideAttrs (old: {
        node_modules = old.node_modules.overrideAttrs {
          outputHash = "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA=";
        };
      });
    })
  ];
}
