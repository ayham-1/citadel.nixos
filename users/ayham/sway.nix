{ config, pkgs, lib, ... }: {
  imports = [ <home-manager/nixos> ];
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
    xdg.portal = { enable = true; };

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
          titlebar = {
            border = 1;
            padding = 1;
          };
          border = 1;
        };
        input = {
          "*" = { natural_scroll = false; };
          "type:keyboard" = {
            xkb_layout = "us,de";
            xkb_options = "caps:escape,grp:win_space_toggle";
            repeat_delay = 150;
            repeat_rate = 25;
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
            natural_scroll = "disabled";
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

  home-manager.users.ayham = {
    programs.i3status = {
      enable = true;
      config = {
        general = {
          colors = true;
          interval = 1;
          output_format = "i3bar";
        };

        order = [
          "ipv6"
          "disk /"
          "wireless _first_"
          "ethernet _first_"
          "memory"
          "cpu_usage"
          "load"
          "battery 0"
          "tztime local"
        ];

        "wireless _first_" = {
          format_up = "W: (%quality at %essid) %ip";
          format_down = "W: down";
        };

        "ethernet _first_" = {
          format_up = "E: %ip (%speed)";
          format_down = "E: down";
        };

        "tztime local" = { format = "%A, %d.%m.%Y %H:%M:%S"; };

        cpu_usage = { format = "CPU: %usage"; };

        load = { format = "%5min"; };

        memory = {
          format = "%used";
          threshold_degraded = "10%";
          format_degraded = "MEMORY: %free";
        };

        "battery 0" = {
          format = "%status %percentage %remaining";
          format_down = "";
          status_chr = "CHR";
          status_bat = "BAT";
          status_unk = "UNK";
          status_full = "FULL";
          path = "/sys/class/power_supply/BAT%d/uevent";
          low_threshold = 10;
        };

        "disk /" = { format = "%free"; };
      };
    };
  };
  programs.gamemode.enable = true;
}
