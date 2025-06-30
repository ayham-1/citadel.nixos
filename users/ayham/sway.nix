{ config, pkgs, lib, home-manager, ... }: {
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      tofi
      mako
      wdisplays
      qt5.qtwayland
      grim
      slurp
      swappy
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      waybar
    ];
  };
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;

  home-manager.users.ayham = {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
    home.stateVersion = "25.05";

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
      config = rec {
        modifier = "Mod4";
        terminal = "kitty";
        menu = "dmenu_path | wmenu -b | xargs swaymsg exec --";
        focus.followMouse = "always";
        floating.modifier = "Mod4";
        gaps = {
          inner = 5;
          outer = 5;
          smartBorders = "on";
          smartGaps = true;
        };
        fonts = {
          names = [ "monospace" ];
          size = 10.0;
        };
        window = {
          titlebar = true;
          border = 1;
        };
        input = {
          "type:keyboard" = {
            xkb_layout = "us,de";
            xkb_options = "caps:escape,grp:win_space_toggle";
            repeat_delay = "150";
            repeat_rate = "25";
          };
          "type:mouse" = {
            accel_profile = "flat";
            pointer_accel = "0.5";
          };
          "TrackBall" = {
            accel_profile = "flat";
            pointer_accel = "0";
          };
          "type:touchpad" = {
            tap = "enabled";
            dwt = "enabled";
            natural_scroll = "false";
          };
          "type:tablet_pad" = { map_to_output = "HDMI-A-1"; };
          "type:tablet_tool" = { map_to_output = "HDMI-A-1"; };
        };
      };
      xwayland = true;
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        # needs qt5.qtwayland in systemPackages
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
      extraConfig = ''
        bar {
          status_command i3status
          mode hide
          position bottom
          tray_output HDMI-A-1
        }
      '';
    };
  };
  programs.gamemode.enable = true;
}
