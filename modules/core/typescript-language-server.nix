# nixos-unstable 7fd4004 ships a stale pnpmDeps hash (nixpkgs#573730).
# Drop once unstable includes https://github.com/NixOS/nixpkgs/pull/572951.
final: prev: let
  broken = "sha256-MUSxDMlbG21KSesGdEvqa2kEpuVfLlXRUX1qV/FGsSo=";
  fixed = "sha256-xR/EF60lVBsITKgH7wCM2wHM46PFQevD51KfCENSUH4=";
in {
  typescript-language-server =
    if prev.typescript-language-server.pnpmDeps.outputHash == broken
    then
      prev.typescript-language-server.overrideAttrs (old: {
        pnpmDeps = old.pnpmDeps.overrideAttrs {
          outputHash = fixed;
        };
      })
    else prev.typescript-language-server;
}
