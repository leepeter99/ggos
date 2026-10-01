{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions =
        prev.pythonPackagesExtensions
        ++ [
          (pFinal: pPrev: {
            nanoemoji = pPrev.nanoemoji.overrideAttrs (old: {
              src = old.src.overrideAttrs (_: {
                outputHash = "sha256-FysyKC01XBnRiur5RR9fcsTxQqE8x0JJHSoe3q6JtKc=";
              });
            });
          })
        ];
      dwarfs =
        (prev.dwarfs.override {
          fmt = prev.fmt_11;
        }).overrideAttrs (old: {
          env =
            (old.env or {})
            // {
              CXXFLAGS = (old.env.CXXFLAGS or "") + " -include cstring -Wno-error";
            };
          cmakeFlags = (old.cmakeFlags or []) ++ ["-DENABLE_WERROR=OFF"];
        });
      herdr = prev.herdr.overrideAttrs (old: {
        # binutils 2.46 errors on overlapping FDEs in zig's libghostty-vt
        # when rustc passes --eh-frame-hdr. lld then dies on a zig 0.16
        # compiler_rt relocation, so stay on bfd and skip the hdr index.
        env =
          (old.env or {})
          // {
            RUSTFLAGS = (old.env.RUSTFLAGS or "") + " -C link-arg=-Wl,--no-eh-frame-hdr";
          };
      });
      obs-studio-plugins =
        prev.obs-studio-plugins
        // {
          obs-composite-blur = prev.obs-studio-plugins.obs-composite-blur.overrideAttrs (old: {
            # Preserve constness for strrchr with the updated C toolchain.
            postPatch =
              (old.postPatch or "")
              + ''
                substituteInPlace src/obs-utils.c \
                  --replace-fail "char *pos = strrchr(file_name, '/');" "const char *pos = strrchr(file_name, '/');"
              '';
          });
          obs-move-transition = prev.obs-studio-plugins.obs-move-transition.overrideAttrs (old: {
            NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "") + " -Wno-error=deprecated-declarations";
          });
        };
      cortex = final.callPackage ../../pkgs/cortex {};
    })
  ];
}
