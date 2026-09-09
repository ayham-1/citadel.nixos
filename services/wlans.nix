{
  lib,
  config,
  ...
}: {
  options = {
    citadel.wlans.home.enable = lib.mkEnableOption "Citadel: wlan home";
    citadel.wlans.ovgu.enable = lib.mkEnableOption "Citadel: wlan ovgu";
    citadel.wlans.hti.enable = lib.mkEnableOption "Citadel: wlan hti";
  };

  config = {
    sops.secrets."wireless.env".neededForUsers = true;
    sops.secrets."wireless.env" = {};

    networking.networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [config.sops.secrets."wireless.env".path];
        profiles = {
          home-wifi = lib.mkIf config.citadel.wlans.home.enable {
            connection.id = "home-wifi";
            connection.type = "wifi";

            wifi.ssid = "$home_ssid";
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "$home_psk";
            };
          };

          ovgu-wifi = lib.mkIf config.citadel.wlans.ovgu.enable {
            connection.id = "ovgu-wifi";
            connection.type = "wifi";

            wifi.ssid = "$ovgu_ssid";
            wifi.security = "802-11-wireless-security";

            "802-11-wireless-security" = {key-mgmt = "wpa-eap";};

            "802-1x" = {
              eap = "peap";
              identity = "$ovgu_usr";
              password = "$ovgu_psk";
              phase2-auth = "mschapv2";
              #ca-cert = "/etc/ssl/certs/ca-certificates.crt";
            };
          };

          hti-lab = lib.mkIf config.citadel.wlans.hti.enable {
            connection.id = "hti-lab";
            connection.type = "ethernet";
            connection.autoconnect = "true";
            ipv4.method = "manual";
            ipv4.addresses = "141.44.61.64/24";
            ipv4.dns = "141.44.1.1";
            ipv4.dns-search = "uni-magdeburg.de";
            ipv4.gateway = "141.44.61.200";
          };
        };
      };
    };
  };
}
