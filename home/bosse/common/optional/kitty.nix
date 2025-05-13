{...}: {
  programs.kitty = {
    enable = true;
    font.name = "MesloLGS Nerd Font";
    font.size = 12;
    keybindings = {
      "ctrl+KP_Add" = "change_font_size all +2.0";
      "ctrl+KP_Subtract" = "change_font_size all -2.0";
      "ctrl+equal" = "change_font_size all 0";
      "0x1008ff57" = "copy_to_clipboard";
      "0x1008ff6d" = "paste_from_clipboard";
    };
    environment = {
      "TERM" = "xterm-256color";
    };
    shellIntegration.enableZshIntegration = true;
    extraConfig = ''
      # Cursor
      cursor_shape block
      cursor_trail 1
      cursor_trail_decay 0.1 0.2

      # OSC 52 clipboard support (copy/paste)
      allow_remote_control yes

      # Kitty
      confirm_os_window_close 0
      enable_audio_bell no

      # Mouse
      mouse_map left click ungrabbed mouse_handle_click selection link prompt
      mouse_map middle release ungrabbed paste_from_selection

      # Theme
      background #1a1b26
      foreground #c0caf5
      selection_background #283457
      selection_foreground #c0caf5
      url_color #73daca
      cursor #c0caf5
      cursor_text_color #1a1b26

      # Tabs
      active_tab_background #7aa2f7
      active_tab_foreground #16161e
      inactive_tab_background #292e42
      inactive_tab_foreground #545c7e
      #tab_bar_background #15161e

      # Windows
      active_border_color #7aa2f7
      inactive_border_color #292e42

      # normal
      color0 #15161e
      color1 #f7768e
      color2 #9ece6a
      color3 #e0af68
      color4 #7aa2f7
      color5 #bb9af7
      color6 #7dcfff
      color7 #a9b1d6

      # bright
      color8  #414868
      color9  #ff899d
      color10 #9fe044
      color11 #faba4a
      color12 #8db0ff
      color13 #c7a9ff
      color14 #a4daff
      color15 #c0caf5

      # extended colors
      color16 #ff9e64
      color17 #db4b4b

      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono
    '';
  };
}
