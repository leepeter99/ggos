{pkgs, inputs, ...}: {
  # Google Antigravity IDE
  home.packages = [
    inputs.antigravity-nix.packages.${pkgs.system}.google-antigravity-ide
  ];
}
