{ config, pkgs, home-manager, ... }: {
  home-manager.users.ayham = {
    programs.rofi = {
      enable = true;

    # Use drun and run modes (most common)
    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      #font = "Fira Code 12";
      #terminal = "alacritty";  # Optional: set your terminal
    };

    #theme = "gruvbox-dark";  # Built-in theme (or use your own below)
    };
  };
}
