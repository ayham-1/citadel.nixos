{...}: {
  flake.citadel.modules.network.wlans = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options = {
      citadel.wlans.home.enable = lib.mkEnableOption "Citadel: wlan home";
      citadel.wlans.ovgu.enable = lib.mkEnableOption "Citadel: wlan ovgu";
      citadel.wlans.hotspot.enable = lib.mkEnableOption "Citadel: wlan hotspot";
    };

    config = {
      sops.secrets."wireless.env".neededForUsers = true;
      sops.secrets."wireless.env" = {};

      networking = {
        networkmanager = {
          ensureProfiles = {
            environmentFiles = [config.sops.secrets."wireless.env".path];
            profiles = {
              home-wifi = lib.mkIf config.citadel.wlans.home.enable {
                connection = {
                  id = "home-wifi";
                  type = "wifi";
                  zone = "trusted-wlan";
                };

                wifi.ssid = "$home_ssid";
                wifi-security = {
                  auth-alg = "open";
                  key-mgmt = "wpa-psk";
                  psk = "$home_psk";
                };
              };

              ovgu-wifi = lib.mkIf config.citadel.wlans.ovgu.enable {
                connection = {
                  id = "ovgu";
                  type = "wifi";
                  zone = "untrusted-wlan";
                };

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
            };
          };
        };
      };
    };
  };
}
