{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      obs-studio-plugins =
        prev.obs-studio-plugins
        // {
          # 3.2.1 still calls deprecated obs_properties_add_button under -Werror.
          obs-move-transition = prev.obs-studio-plugins.obs-move-transition.overrideAttrs (old: {
            NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "") + " -Wno-error=deprecated-declarations";
          });
        };
      cortex = final.callPackage ../../pkgs/cortex {};
    })
  ];
}
