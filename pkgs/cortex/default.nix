{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  nodejs,
}: let
  version = "0.0.5";
  src = fetchurl {
    url = "https://registry.npmjs.org/@inscapist/cortex/-/cortex-${version}.tgz";
    hash = "sha256-PXOzZlmgyI+s8gUomzicikfbGCp9tm0pUGtZBwjYEvs=";
  };
  binarySrc = fetchurl {
    url = "https://registry.npmjs.org/@inscapist/cortex-linux-x64/-/cortex-linux-x64-${version}.tgz";
    hash = "sha256-hYjDBX+z/fzVmAw8MyF4lvzNvc0wcQOIlacdQHGmaZc=";
  };
in
  stdenv.mkDerivation {
    pname = "cortex";
    inherit version;

    srcs = [src binarySrc];
    sourceRoot = ".";

    nativeBuildInputs = [autoPatchelfHook makeWrapper];

    # Packed static binary; stripping breaks it.
    dontStrip = true;

    unpackPhase = ''
      runHook preUnpack
      mkdir wrapper binary
      tar -xzf ${src} -C wrapper --strip-components=1
      tar -xzf ${binarySrc} -C binary --strip-components=1
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      install -Dm755 binary/cortex-local $out/lib/cortex-local

      mkdir -p $out/share/cortex
      cp -r wrapper/skills $out/share/cortex/skills

      # Keep npm-relative layout so cortex-install.js finds ../skills
      mkdir -p $out/libexec/cortex/bin
      cp wrapper/bin/cortex-install.js $out/libexec/cortex/bin/
      cp -r wrapper/skills $out/libexec/cortex/skills

      mkdir -p $out/bin
      makeWrapper $out/lib/cortex-local $out/bin/cortex-local
      makeWrapper ${lib.getExe nodejs} $out/bin/cortex-install \
        --add-flags $out/libexec/cortex/bin/cortex-install.js

      runHook postInstall
    '';

    meta = {
      description = "Local project memory for coding agents";
      homepage = "https://www.npmjs.com/package/@inscapist/cortex";
      license = lib.licenses.unfree;
      platforms = ["x86_64-linux"];
      mainProgram = "cortex-local";
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }
