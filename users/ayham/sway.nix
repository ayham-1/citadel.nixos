{ config, pkgs, lib, home-manager, stylix, ... }: {
  home-manager.users.ayham = {
    xdg.portal = {
      enable = true;
      configPackages = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-wlr ];
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.wayprompt.enable = true;
    programs.swaylock.enable = true;

    services.mako.enable = true;

    wayland.windowManager.sway = let
      mod = "Mod4";
      terminal = "kitty";
      menu = "dmenu_path | wmenu -b | xargs swaymsg exec --";
      screenshot = ''grim -g "$(slurp)" - | swappy -f -'';
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
        bars = [({
          mode = "hide";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = true;
          workspaceNumbers = false;
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
          trayOutput = "primary";
        })];
        keybindings = lib.mkOptionDefault {
          "${mod}+u" = "exec ${menu}";
          "${mod}+Shift+d" = "exec ${screenshot}";
          "${mod}+Shift+s" = "exec ${lock}";
          "${mod}+Shift+p" = "exec systemctl suspend & ${lock}";
          "${mod}+Shift+c" = "kill";
          "${mod}+Shift+r" = "reload";
          "${mod}+Shift+f" = "floating toggle";
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86MonBrightnessDown" = "exec light -U 5";
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

    programs.i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [{
              alert = 10.0;
              block = "disk_space";
              info_type = "available";
              interval = 60;
              path = "/";
              warning = 20.0;
            }
            {
              block = "memory";
              format = " $icon mem_used_percents ";
              format_alt = " $icon $swap_used_percents ";
            }
            {
              block = "cpu";
              interval = 1;
            }
            {
              block = "load";
              format = " $icon $1m ";
              interval = 1;
            }
            {
              block = "sound";
            }
            {
              block = "time";
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
              interval = 60;
            }
          ];
        };
      };
    };
  };
  programs.gamemode.enable = true;
}
