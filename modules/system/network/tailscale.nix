{...}: {
  flake.citadel.modules.network.tailscale = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options = {
      citadel.tailscale.enable = lib.mkEnableOption "Citadel: Tailscale Network";
    };

    config = lib.mkIf config.citadel.tailscale.enable {
      services = {
        tailscale = {
          enable = true;
          authKeyFile = "/etc/tailscale.key";
        };
      };

      sops.secrets."private_keys/tailscale" = {
        mode = "0400";
        path = "/etc/tailscale.key";
      };

      networking = {
        firewall = {
          trustedInterfaces = [config.services.tailcale.interfaceName];
          allowedUDPPorts = [config.services.tailscale.port];
        };
      };
    };
  };
}
