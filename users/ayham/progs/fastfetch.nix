{...}: {
  home-manager.users.ayham = {pkgs, ...}: {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "nixos";
          padding = {
            right = 1;
          };
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          color = "blue";
          separator = "  ";
        };
        modules = [
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }
          "uptime"

          "break"
          {
            type = "os";
            key = "OS";
            keyColor = "blue";
            format = "{name} {version}";
          }
          {
            type = "kernel";
            key = "Kernel";
          }
          "initsystem"
          "bios"
          "bootmgr"
          "board"
          "battery"
          "poweradapter"
          "chassis"

          "break"
          "cpu"
          "gpu"
          {
            type = "memory";
            key = "Memory";
            percent = {
              type = 3;
              green = 30;
              yellow = 70;
            };
          }

          "break"
          "mouse"
          "keyboard"

          "break"
          "packages"
          "disk"
          "btrfs"

          "break"
          "lm"
          "de"
          "wm"
          "terminal"
          "theme"
          "wmtheme"
          "terminalfont"

          "break"
          "host"
          "dns"
          "localip"
          "wifi"
        ];
      };
    };
  };
}
