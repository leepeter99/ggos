{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      cortex = final.callPackage ../../pkgs/cortex {};

      # nixpkgs' cargo-setup-hook exports ZSTD_SYS_USE_PKG_CONFIG=1 for every
      # Rust build, which makes zstd-sys probe pkg-config. The syswatch package
      # doesn't declare the pkg-config/zstd inputs that probe needs. Drop once
      # nixpkgs fixes the package.
      syswatch = prev.syswatch.overrideAttrs (old: {
        nativeBuildInputs = old.nativeBuildInputs ++ [final.pkg-config];
        buildInputs = old.buildInputs ++ [final.zstd];
      });

      # netwatch's linux sandbox test opens a raw socket with TCP_FASTOPEN,
      # which the Nix build sandbox denies (EACCES). Skip it like nixpkgs
      # already does for the sibling diskwatch package.
      netwatch = prev.netwatch.overrideAttrs (old: {
        cargoTestFlags = [
          "--"
          "--skip=parser_layer_leaves_fast_open_and_autobind_open"
        ];
      });
    })
  ];
}
