_: {
  ggos.niri.configParts.windowRules = ''
    // Window rules
    window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
    }

    window-rule {
        match app-id=r#"(?i)rio(term)?"#
        opacity 0.90
    }

    window-rule {
        match app-id=r#"(?i)zen(-beta|-browser)?"#
    }

    // Noctalia settings panel: floating, centered, 70% of the screen
    window-rule {
        match app-id=r#"^dev\.noctalia\.Noctalia$"#
        match title=r#"^Noctalia$"#
        open-floating true
        default-column-width { proportion 0.7; }
        default-window-height { proportion 0.7; }
    }
  '';
}
