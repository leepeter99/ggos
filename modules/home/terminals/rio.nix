{lib, ...}: let
  fontFamily = "Maple Mono NF";
in {
  programs.rio = {
    enable = true;
    settings = {
      "confirm-before-quit" = false;
      fonts.family = lib.mkForce fontFamily;
      window = {
        opacity = lib.mkForce 0.90;
        opacity-cells = false;
      };
      bindings.keys = [
        {
          key = "q";
          "with" = "super";
          action = "Quit";
        }
      ];
    };
  };
}
