{ config, pkgs, lib, home-manager, stylix, ... }: {
  options = {
    citadel.users.wm.bars.waybar.enable = lib.mkEnableOption "Citadel: Enables Waybar userconfig";
  };

  config = lib.mkIf config.citadel.users.wm.bars.waybar.enable {
    programs.waybar.enable = true;

    home-manager.users.ayham = {
      stylix.targets.waybar.enableCenterBackColors = true;
      stylix.targets.waybar.enableRightBackColors = true;
      stylix.targets.waybar.enableLeftBackColors = true;
      programs.waybar = {
        enable = true;
        style = ''
          * {
          font-size: 10px;
          min-height: 0;
          }
        '';
        settings = {
          default = {
            ipc = true;
            layer = "top";
            position = "top";
            height = 14;
            modules-left = [ "sway/workspaces" "sway/mode" ];
            modules-center = [ "gamemode" "sway/window" "systemd-failed-units" ];
            modules-right = [ "mpd" "privacy" "wireplumber" "network" "cpu" "memory" "battery" "clock" "tray" ];

            "sway/workspaces" = {
              disable-scroll = true;
              all-outputs = true;
            };

            "systemd-failed-units" = {
              "hide-on-ok"= false;
              "format"= "✗ {nr_failed}";
              "format-ok"= "";
              "system"= true;
              "user"= false;
            };

            "gamemode" = {
              "format"= "{glyph}";
              "format-alt"= "{glyph} {count}";
              "hide-not-running"= true;
              "use-icon"= true;
              "icon-name"= "input-gaming-symbolic";
              "icon-spacing"= 4;
              "icon-size"= 20;
              "tooltip"= true;
              "tooltip-format"= "Games running: {count}";
            };

            "cpu" = {
              "format"= "{}% {icon0} {icon1} {icon2} {icon3} {icon4} {icon5} {icon6} {icon7}";
              "format-icons" = ["▁"  "▂"  "▃"  "▄"  "▅"  "▆"  "▇"  "█"];
              "max-length" = 15;
            };
            "memory" = {
              "interval" = 30;
              "format" = "{used:0.1f}G/{total:0.1f}G ";
            };

            "wireplumber" = {
              "format"= "{volume}%";
              "format-muted"= "";
              "on-click"= "helvum";
              "max-volume"= 150;
              "scroll-step"= 0.2;
            };

            "battery"= {
              "format"= "{capacity}% {icon}";
              "format-icons"= [""  ""  ""  ""  ""];
            };

            "privacy"= {
              "icon-spacing"= 4;
              "transition-duration"= 250;
              "modules"= [
                {
                  "type"= "screenshare";
                  "tooltip"= true;
                }
                {
                  "type"= "audio-out";
                  "tooltip"= true;
                }
                {
                  "type"= "audio-in";
                  "tooltip"= true;
                }
              ];
              "ignore-monitor"= true;
              "ignore"= [
                {
                  "type"= "audio-in";
                  "name"= "cava";
                }
                {
                  "type"= "screenshare";
                  "name"= "obs";
                }
              ];
            };

            "network"= {
              "format"= "{ifname}";
              "format-wifi"= "{essid} ({signalStrength}%) ";
              "format-ethernet"= "{ipaddr}/{cidr}";
              "format-disconnected"= "";
              "tooltip-format"= "{ifname} via {gwaddr}";
              "tooltip-format-wifi"= "{essid} ({signalStrength}%) ";
              "tooltip-format-ethernet"= "{ifname} ";
              "tooltip-format-disconnected"= "Disconnected";
              "max-length"= 50;
            };

            "clock"= {
              "format" = "{:%H:%M}  ";
              "format-alt" = "{:L%A, %B %d, %Y (%R)}  ";
              "tooltip-format" = "<tt><small>{calendar}</small></tt>";
              "calendar" = {
                "mode"          = "year";
                "mode-mon-col"  = 3;
                "weeks-pos"     = "right";
                "on-scroll"     = 1;
              #"format"= {
              #  "months"=     "<span color='#ffead3'><b>{}</b></span>";
              #  "days"=       "<span color='#ecc6d9'><b>{}</b></span>";
              #  "weeks"=      "<span color='#99ffdd'><b>W{}</b></span>";
              #  "weekdays"=   "<span color='#ffcc66'><b>{}</b></span>";
              #  "today"=      "<span color='#ff6699'><b><u>{}</u></b></span>";
              #};
            };
            "actions" =  {
              "on-click-right"= "mode";
              "on-click-forward"= "tz_up";
              "on-click-backward"= "tz_down";
              "on-scroll-up"= "shift_up";
              "on-scroll-down"= "shift_down";
            };
          };

        };
      };
    };
  };
};
}
