{ config, pkgs, lib, stylix, ... }: {
  imports = [ stylix.nixosModules.stylix ];

  # enable brightness control
  programs.light.enable = true;

  programs.dconf.enable = true;

  # common tools
  environment.systemPackages = with pkgs; [
    bitwarden
    bitwarden-cli
    mpv
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
  ];

  # theme
  stylix = {
    enable = true;
    image = ../assets/wallpaper.jpg;
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
    polarity = "dark";
  };
}
