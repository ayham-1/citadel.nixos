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
      };
      font.size = lib.mkDefault 10;
      shellIntegration.enableBashIntegration = true;
      shellIntegration.enableZshIntegration = true;
    };
  };
}
