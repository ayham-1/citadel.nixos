{
  config,
  pkgs,
  lib,
  stylix,
  ...
}: {
  hardware.acpilight.enable = true;

  programs.dconf.enable = true;

  # zsa
  hardware.keyboard.zsa.enable = true;

  # common tools
  environment.systemPackages = with pkgs; [
    # zsa
    wally-cli
    keymapp

    bitwarden-desktop
    bitwarden-cli
    mpv
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    tigervnc
    opentabletdriver
    pciutils
    eduvpn-client
    keepassxc

    dejavu_fonts
    noto-fonts-color-emoji
    adwaita-icon-theme
    cachix
    sxiv

    gimp
  ];
  programs.thunderbird.enable = true;

  networking.networkmanager.plugins = with pkgs; [networkmanager-openvpn];
  networking.firewall.checkReversePath = "loose";

  # drawing tablet thing
  hardware.opentabletdriver.enable = true;
  services.udev.packages = [pkgs.opentabletdriver];

  # mainly for stlink
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
    image = ../assets/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/bright.yaml";
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    cursor = {
      package = pkgs.banana-cursor;
      size = 28;
      name = "Banana";
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    polarity = "dark";
  };

  # fixes
  #nixpkgs.overlays = [
  #  (_: prev: {
  #    openldap = prev.openldap.overrideAttrs {
  #      doCheck = !prev.stdenv.hostPlatform.isi686;
  #    };
  #  })
  #];
}
