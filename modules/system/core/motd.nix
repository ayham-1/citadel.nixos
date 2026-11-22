{moduleWithSystem, ...}: {
  flake.citadel.modules.core.motd = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    lib',
    ...
  }: {
    systemd.services.rust-motd = {
      description = "Generate MOTD with rust-motd";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.rust-motd}/bin/rust-motd /etc/rust-motd/config.kdl > /etc/motd'";
      };
    };

    systemd.timers.rust-motd = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "15min";
      };
    };

    programs.rust-motd = {
      enable = true;
      enableMotdInSSHD = true;

      order = [
        "weather"
        "uptime"
        "service_status"
        "filesystems"
      ];

      settings = {
        weather = {
          loc = "Berlin,Europe";
          style = "full";
          timeout = 10;
        };

        uptime = {
          prefix = "Uptime";
        };

        service_status = {
          Accounts = "accounts-daemon";
        };

        filesystems = {
          root = "/";
          home = "/home";
        };
      };
    };
    environment.systemPackages = [
      pkgs.rust-motd
    ];
  });
}
