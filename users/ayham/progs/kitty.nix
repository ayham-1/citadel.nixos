{ config, pkgs, lib, home-manager, ... }: {
  home-manager.users.ayham = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      environment = { "LS_COLORS" = "1"; };
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
        cursor_trail_start_threshold = 2;
        cursor_shape = "block";
        cursor_blink_interval = "-1";
        cursor_stop_blinking_after = "15.0";
      };
      font.size = lib.mkDefault 10;
      shellIntegration.enableBashIntegration = true;
      shellIntegration.enableZshIntegration = true;
    };
  };
}
