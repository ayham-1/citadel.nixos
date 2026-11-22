{...}: {
  flake.citadel.modules.network = {pkgs, ...}: {
    networking = {
      networkmanager = {
        enable = true;
        dns = "none";
        plugins = with pkgs; [
          networkmanager-openvpn
        ];
      };

      nameservers = ["1.1.1.1" "8.8.8.8"];

      nftables.enable = true;
    };

    services = {
      firewalld = {
        enable = true;
      };
    };

    programs.nm-applet = {
      enable = true;
    };

    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;
  };
}
