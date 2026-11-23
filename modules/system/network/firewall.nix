{...}: {
  flake.citadel.modules.network.firewall = {
    config,
    lib,
    pkgs,
    ...
  }: {
    networking.firewall = {
      enable = true;
      backend = "firewalld";
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };

    services.firewalld = {
      enable = true;

      settings = {
        DefaultZone = "untrusted-wlan";
      };

      zones = {
        tailscale = {
          target = "DROP";
          interfaces = [config.services.tailscale.interfaceName];
          services = ["ssh"];
          ports = [
            {
              port = config.services.tailscale.port;
              protocol = "udp";
            }
          ];
        };

        trusted-wlan = {
          target = "DROP";
          services = ["ssh"];
          ports = [];
        };

        trusted-lan = {
          target = "DROP";
          services = ["ssh"];
          ports = [];
        };

        untrusted-wlan = {
          target = "DROP";
        };
      };
    };
  };
}
