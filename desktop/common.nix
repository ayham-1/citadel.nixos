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

  # magic FHS
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = pkgs.steam-run.args.multiPkgs pkgs;

  # sometimes, perfect is unachievable
  services.flatpak.enable = true;

  # theme
  stylix = {
    enable = true;
    image = ../assets/wallpaper.png;
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
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 48;
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    polarity = "dark";
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      sway = {
        prettyName = "Sway";
        comment = "Sway compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/sway";
      };
      niri = {
        prettyName = "Niri";
        comment = "Niri compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
  };

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --background matrix --time --battery --asterisks --user-menu --sessions /run/current-system/sw/share/wayland-sessions";
        user = "greeter";
      };
    };
  };
}
