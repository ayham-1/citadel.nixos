{ config, pkgs, lib, stylix, ... }: {
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
    tigervnc
    libsForQt5.xp-pen-g430-driver
    opentabletdriver
  ];

  # drawing tablet thing
  hardware.opentabletdriver.enable = true;
  services.udev.packages = [
    pkgs.opentabletdriver
  ];
  systemd.user.services.opentabletdriver = {
  
  #services.udev.packages = [ pkgs.digimend-udev-rules ];
  #boot.extraModulePackages = with config.boot.kernelPackages; [ digimend ];

  # theme
  stylix = {
    enable = true;
    image = ../assets/wallpaper.jpg;
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
    cursor = {
      package = pkgs.banana-cursor;
      size = 24;
      name = "Banana";
    };
    polarity = "dark";
  };
}
