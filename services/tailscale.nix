{
  lib,
  config,
  ...
}: {
  options = {
    citadel.tailscale.enable = lib.mkEnableOption "Citadel: Tailscale Network";
  };

  config = lib.mkIf config.citadel.tailscale.enable {
    services.tailscale.enable = true;
    services.tailscale.authKeyFile = "/root/.tailscale.key";
    networking.firewall.trustedInterfaces = ["tailscale0"];
  };
}
