{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    citadel.users.wm.niri.enable = lib.mkEnableOption "citadel: enables niri userconfig";
  };

  config = lib.mkIf config.citadel.users.wm.niri.enable {
    environment.systemPackages = with pkgs; [
      xwayland-satellite # xwayland support
    ];

    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };

    programs.niri.enable = true;
    home-manager.users.ayham = {
      programs.niri = {
        enable = true;
        package = pkgs.niri;

        settings = {
          prefer-no-csd = true;

          spawn-at-startup = [
            {
              command = [
                "${pkgs.swaybg}/bin/swaybg"
                "-i"
                "${config.stylix.image}"
                "-m"
                "fill"
              ];
            }
          ];

          workspaces = {
            "1" = {};
            "2" = {};
            "3" = {};
            "4" = {};
            "5" = {};
            "6" = {};
          };

          # Input & Keyboard settings
          input = {
            keyboard = {
              xkb = {
                layout = "us,de";
                options = "caps:escape,grp:win_space_toggle";
              };
              repeat-delay = 300;
              repeat-rate = 25;
            };

            touchpad = {
              tap = true;
              natural-scroll = true;
            };

            mouse = {
              natural-scroll = false;
            };
          };

          # Window layout & aesthetics
          layout = {
            gaps = 8;

            center-focused-column = "never";

            preset-column-widths = [
              {proportion = 0.33333;}
              {proportion = 0.5;}
              {proportion = 0.66667;}
            ];

            default-column-width = {proportion = 0.5;};

            focus-ring = {
              enable = true;
              width = 2;
              active.color = "#7aa2f7";
              inactive.color = "#414868";
            };

            border = {
              enable = false;
              width = 2;
            };

            struts = {
              left = 0;
              right = 0;
              top = 0;
              bottom = 0;
            };
          };

          # Environment variables for Wayland apps
          environment = {
            NIXOS_OZONE_WL = "1";
            DISPLAY = ":0";
          };

          # Window rules
          window-rules = [
            {
              geometry-corner-radius = {
                top-left = 8.0;
                top-right = 8.0;
                bottom-left = 8.0;
                bottom-right = 8.0;
              };
              clip-to-geometry = true;
            }
          ];
          outputs = {
            "HDMI-A-1" = {
              enable = true;
              position = {
                x = 0;
                y = 0;
              }; # Primary screen at the origin
              scale = 1.0;
            };

            "DP-1" = {
              enable = true;
              position = {
                x = 1920;
                y = 0;
              };
              scale = 1.0;
            };
          };

          binds = {
            # Application Shortcuts
            "super+Return".action.spawn = ["kitty"];
            "super+D".action.spawn = ["fuzzel"];
            "super+P".action.spawn = ["swaylock"];
            "super+Shift+D".action.spawn = [
              "sh"
              "-c"
              ''grim -g "$(slurp)" - | satty -f -''
            ];

            # Window Actions
            "super+Q".action.close-window = {};
            "super+F".action.maximize-column = {};
            "super+Shift+F".action.fullscreen-window = {};
            "super+C".action.center-column = {};

            # Focus Navigation (Vim & Arrow keys)
            "super+Left".action.focus-column-left = {};
            "super+Right".action.focus-column-right = {};
            "super+Down".action.focus-window-down = {};
            "super+Up".action.focus-window-up = {};
            "super+H".action.focus-column-left = {};
            "super+L".action.focus-column-right = {};
            "super+J".action.focus-window-down = {};
            "super+K".action.focus-window-up = {};

            "super+Home".action.focus-column-first = {};
            "super+End".action.focus-column-last = {};

            # Moving Windows / Columns
            "super+Shift+Left".action.move-column-left = {};
            "super+Shift+Right".action.move-column-right = {};
            "super+Shift+Down".action.move-window-down = {};
            "super+Shift+Up".action.move-window-up = {};
            "super+Shift+H".action.move-column-left = {};
            "super+Shift+L".action.move-column-right = {};
            "super+Shift+J".action.move-window-down = {};
            "super+Shift+K".action.move-window-up = {};

            # Workspace Navigation
            "super+U".action.focus-workspace-down = {};
            "super+I".action.focus-workspace-up = {};
            "super+Shift+U".action.move-column-to-workspace-down = {};
            "super+Shift+I".action.move-column-to-workspace-up = {};

            "super+1".action.focus-workspace = 1;
            "super+2".action.focus-workspace = 2;
            "super+3".action.focus-workspace = 3;
            "super+4".action.focus-workspace = 4;
            "super+5".action.focus-workspace = 5;

            "super+Shift+1".action.move-column-to-workspace = 1;
            "super+Shift+2".action.move-column-to-workspace = 2;
            "super+Shift+3".action.move-column-to-workspace = 3;
            "super+Shift+4".action.move-column-to-workspace = 4;
            "super+Shift+5".action.move-column-to-workspace = 5;

            # Sizing & Layout Control
            "super+R".action.switch-preset-column-width = {};
            "super+Minus".action.set-column-width = "-10%";
            "super+Equal".action.set-column-width = "+10%";
            "super+Shift+Minus".action.set-window-height = "-10%";
            "super+Shift+Equal".action.set-window-height = "+10%";

            # Monitor Focus and Change
            "super+comma".action.focus-monitor-left = {};
            "super+period".action.focus-monitor-right = {};
            "super+Shift+comma".action.move-column-to-monitor-left = {};
            "super+Shift+period".action.move-column-to-monitor-right = {};

            # System Controls / Multimedia
            "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
            "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
            "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
            "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "10%+"];
            "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "10%-"];

            "super+Shift+E".action.quit = {};

            # Move focused window to floating
            "super+Ctrl+F".action.move-window-to-floating = {};

            # Move floating window back to tiling
            "Mod+Ctrl+T".action.move-window-to-tiling = {};

            # Show important keybindings
            "super+Shift+Slash".action.show-hotkey-overlay = {};

            # Toggle overview
            "super+O".action.toggle-overview = {};
          };
        };
      };

      # Essential Companion Apps
      programs.alacritty.enable = true;
      programs.fuzzel.enable = true;
      programs.kitty.enable = true;
    };
  };
}
