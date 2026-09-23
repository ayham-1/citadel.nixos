{
  config,
  pkgs,
  ...
}: {
  config = {
    hardware.acpilight.enable = true;

    programs.dconf.enable = true;

    # common tools
    environment.systemPackages = with pkgs; [
      bitwarden-desktop
      bitwarden-cli
      mpv
      thunar
      thunar-archive-plugin
      thunar-volman
      tigervnc
      opentabletdriver
      pciutils
      eduvpn-client
      keepassxc
      wdisplays

      dejavu_fonts
      noto-fonts-color-emoji
      adwaita-icon-theme
      cachix
      sxiv

      gimp

      wl-kbptr
      kitty
      mako
      grim
      slurp
      satty
      wl-clipboard
    ];
    programs.thunderbird.enable = true;

    networking.networkmanager.plugins = with pkgs; [networkmanager-openvpn];
    networking.firewall.checkReversePath = "loose";

    # drawing tablet thing
    hardware.opentabletdriver.enable = true;
    services.udev.packages = [pkgs.opentabletdriver];

    # sometimes, perfect is unachievable
    services.flatpak.enable = true;

    # theme
    stylix = {
      enable = true;
      polarity = "dark";
      image = ../assets/wallpaper.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruber.yaml";
      fonts = {
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        monospace = {
          package = pkgs.inconsolata;
          name = "Inconsolata";
        };
      };
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 48;
      };
      icons = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };
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
  };
}
