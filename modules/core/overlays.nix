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

    # niri 26.04 pins the Rust crate libdisplay-info-sys 0.3.0, whose
    # pkg-config probe only accepts C libdisplay-info 0.3.x. nixpkgs bumped
    # libdisplay-info to 0.4.0 which breaks the niri build (hydra too, so no
    # cache). Build niri against 0.3.0 until nixpkgs fixes it, then drop this.
    (_final: prev: {
      niri = prev.niri.override {
        libdisplay-info = prev.libdisplay-info.overrideAttrs (_old: rec {
          version = "0.3.0";
          src = prev.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "emersion";
            repo = "libdisplay-info";
            rev = version;
            sha256 = "sha256-nXf2KGovNKvcchlHlzKBkAOeySMJXgxMpbi5z9gLrdc=";
          };
        });
      };
    })
  ];
}
