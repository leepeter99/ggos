{
  host,
  config,
  ...
}: let
  vars = import ../../../hosts/${host}/variables.nix;
  keyboardLayout = vars.keyboardLayout or "us";
  keyboardVariant = vars.keyboardVariant or "";
  niriOutputs = vars.niriOutputs or "";

  c = config.lib.stylix.colors;

  variantLine =
    if keyboardVariant != ""
    then "            variant \"${keyboardVariant}\""
    else "";
in {
  ggos.niri.configParts.base = ''
    // Managed by GGOS Home Manager. Edit modules/home/niri/*.nix
    // (generated). Niri docs: https://yalter.github.io/niri/

    input {
        keyboard {
            xkb {
                layout "${keyboardLayout}"
    ${variantLine}
                options "grp:alt_caps_toggle,caps:super"
            }
            numlock
        }
        touchpad {
            tap
            natural-scroll
            dwt
            accel-profile "flat"
        }
        mouse {}
        warp-mouse-to-focus
        focus-follows-mouse max-scroll-amount="0%"
    }

    ${niriOutputs}

    layout {
        gaps 8
        center-focused-column "never"
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        default-column-width { proportion 0.5; }
        focus-ring {
            width 2
            active-gradient from="#${c.base08}" to="#${c.base0C}" angle=45
            inactive-color "#${c.base01}"
        }
        border {
            off
        }
        struts {
            left 0
            right 0
            top 0
            bottom 0
        }
    }

    prefer-no-csd
    screenshot-path "~/Pictures/ScreenShots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    hotkey-overlay {
        skip-at-startup
    }
  '';
}
