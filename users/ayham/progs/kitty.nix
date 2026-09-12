{lib, ...}: {
  home-manager.users.ayham = {pkgs, ...}: {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      environment = {"LS_COLORS" = "1";};
      settings = {
        allow_remote_control = false;

        # Window
        window_padding_width = 8;
        hide_window_decorations = "yes";

        # Cursor
        cursor_shape = "beam";
        cursor_shape_unfocused = "hollow";
        cursor_blink_interval = -1;

        # Scrollback
        scrollback_lines = 10000;
        scrollbar = "always";

        # Performance
        sync_to_monitor = true;

        # Bell
        enable_audio_bell = false;

        # Tabs
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";

        # URLs
        url_style = "curly";
      };
      shellIntegration.enableBashIntegration = true;
      shellIntegration.enableZshIntegration = true;
    };
  };
}
