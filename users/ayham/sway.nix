{ config, pkgs, lib, home-manager, ... }: {

  home-manager.users.ayham = {
    xdg.portal = {
      enable = true;
      configPackages = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-wlr ];
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.swaylock.enable = true;

    wayland.windowManager.sway = let
      mod = "Mod4";
      terminal = "kitty";
      menu = "dmenu_path | wmenu -b | xargs swaymsg exec --";
      screenshot = ''grim -g "$(slurp)" - | swappy -f'';
      lock = "swaylock";

      left = "h";
      down = "j";
      up = "k";
      right = "l";
    in {
      enable = true;
      swaynag.enable = true;
      wrapperFeatures.gtk = true;
      config = {
        modifier = "${mod}";
        terminal = "${terminal}";
        menu = "${menu}";
        focus.followMouse = "always";
        floating = {
          modifier = "${mod}";
          titlebar = false;
          criteria = [
            { app_id = ".*wl_mirror"; }
            { app_id = "mpv"; }
            { app_id = "qt5ct"; }
            { app_id = "qt6ct"; }
            { app_id = "wdisplays"; }
            { app_id = "xdg-desktop-portal-gtk"; }
            { app_id = "xdg-desktop-portal-wlr"; }
            { app_id = "xdg-desktop-portal"; }
            { app_id = "wayprompt"; }
            { instance = "lxappearance"; }
          ];
        };
        bars = [{command = "waybar"; position = "top"; mode = "hide";}];
        keybindings = lib.mkOptionDefault {
          "${mod}+u" = "exec ${menu}";
          "${mod}+Shift+d" = "exec ${screenshot}";
          "${mod}+Shift+s" = "exec ${lock}";
          "${mod}+Shift+p" = "exec systemctl suspend & ${lock}";
          "${mod}+Shift+c" = "kill";
          "${mod}+Shift+r" = "reload";
          "${mod}+Shift+f" = "floating toggle";
          "${mod}+Shift+q" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

        };
        modes = {
          resize = {
            Escape = "mode default";
            Return = "mode default";
            "${down}" = "resize grow height 5 px or 5 ppt";
            "${left}" = "resize shrink width 5 px or 5 ppt";
            "${right}" = "resize grow width 5 px or 5 ppt";
            "${up}" = "resize shrink height 5 px or 5 ppt";
          };
        };
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
          hideEdgeBorders = "smart";
          commands = [{
            command = "floating enable, sticky enable";
            criteria = { title = "Picture-in-Picture"; };
          }];
        };
        input = {
          "type:keyboard" = {
            xkb_layout = "us,de";
            xkb_options = "caps:escape,grp:win_space_toggle";
            repeat_delay = "300";
            repeat_rate = "50";
          };
          "type:mouse" = {
            accel_profile = "flat";
            pointer_accel = "0.5";
          };
          "*TrackBall*" = {
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
      extraConfig = "";
    };

    programs.waybar = {
      enable = true;

      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 14;
        ipc = "true";
        bar_id = "bar-0";

        modules-left = [ "sway/workspaces" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "network"
          "cpu"
          "memory"
          "battery"
          "pulseaudio"
          "clock"
        ];

        clock.format = "{:%H:%M}";
        cpu.format = "CPU {usage}%";
        memory.format = "RAM {}%";
        battery.format = "BAT {capacity}%";
        pulseaudio.format = "VOL {volume}%";
        network.format-wifi = "WiFi {essid}";
        network.format-ethernet = "LAN {ifname}";
      };
    };
  };
  programs.gamemode.enable = true;
}
