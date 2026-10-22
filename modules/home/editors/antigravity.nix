{
  pkgs,
  inputs,
  ...
}: {
  # Google Antigravity IDE
  home.packages = [
    inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-ide
  ];
}
