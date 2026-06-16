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
  '';
}
