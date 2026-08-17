{inputs, ...}: {
  nixpkgs.overlays = [
    # Build tumbler without EPUB thumbnailer (libgepub) to avoid webkitgtk
    (_final: prev: {
      xfce = prev.xfce // {
        tumbler = prev.xfce.tumbler.overrideAttrs (old: {
          buildInputs = prev.lib.remove prev.libgepub old.buildInputs;
        });
      };
    })
    # dwarfs 0.14.0 bundles folly/fbthrift; fmt 12.2 breaks the build
    (_final: prev: {
      dwarfs = prev.dwarfs.overrideAttrs (old: {
        postPatch =
          (old.postPatch or "")
          + ''
            sed -i '1i #include <cstring>' folly/folly/lang/Exception.h
          '';
        buildInputs = prev.lib.map (
          dep: if prev.lib.getName dep == "fmt" then prev.fmt_11 else dep
        ) old.buildInputs;
      });
    })
  ];
}
