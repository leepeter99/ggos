{...}: {
  programs.rio = {
    enable = true;
<<<<<<< HEAD
    settings = {
      "confirm-before-quit" = false;
      fonts.family = lib.mkForce fontFamily;
      bindings.keys = [
        {
          key = "q";
          "with" = "super";
          action = "Quit";
        }
      ];
    };
||||||| parent of 69223e3 (update system to 2.6.2)
=======
    settings = {
      # Font: override stylix's terminal font to match the other GGOS terminals
      fonts = {
        family = "Maple Mono NF";
        size = 12;
      };

      cursor = {
        shape = "beam";
        blinking = true;
      };

      window = {
        opacity = 1.0;
        blur = false;
        # niri draws the corner radius / clip + prefer-no-csd, so let the WM
        # own decorations (consistent with the niri window-rule).
        decorations = "Disabled";
      };

      navigation = {
        mode = "Tab";
      };

      bindings = {
        keys = [
          # Mod+Q exits the program, consistent with niri's `Mod+Q { close-window; }`
          {
            key = "q";
            "with" = "super";
            action = "Quit";
          }
        ];
      };
    };
>>>>>>> 69223e3 (update system to 2.6.2)
  };
}
