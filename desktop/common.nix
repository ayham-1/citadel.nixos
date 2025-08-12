{
  config,
  pkgs,
  lib,
  stylix,
  ...
}: {
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
    pciutils
    eduvpn-client
    keepassxc

    dejavu_fonts
    noto-fonts-emoji
    adwaita-icon-theme
    cachix
  ];

  # drawing tablet thing
  hardware.opentabletdriver.enable = true;
  services.udev.packages = [pkgs.opentabletdriver];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0666"
  '';

  # magic FHS
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = pkgs.steam-run.args.multiPkgs pkgs;

  # sometimes, perfect is unachievable
  services.flatpak.enable = true;

  # theme
  stylix = {
    enable = true;
    #image = ../assets/wallpaper.jpg;
    base16Scheme = {
      name = "Modus Vivendi";

      base00 = "#000000"; # background
      base01 = "#1a1a1a"; # subtle background
      base02 = "#303030"; # highlight bg
      base03 = "#505050"; # comments
      base04 = "#b0b0b0"; # mid fg
      base05 = "#ffffff"; # foreground
      base06 = "#ffffff"; # emphasis fg
      base07 = "#ffffff"; # strong fg
      base08 = "#ff6f6f"; # red
      base09 = "#ff9f00"; # orange
      base0A = "#ffd700"; # yellow
      base0B = "#44bc44"; # green
      base0C = "#00d3d0"; # cyan
      base0D = "#2fafff"; # blue
      base0E = "#feacd0"; # magenta
      base0F = "#b6a0ff"; # violet
    };
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    cursor = {
      package = pkgs.posy-cursors;
      size = 12;
      name = "Posy_Cursor_Black";
    };
    polarity = "dark";
  };
}
