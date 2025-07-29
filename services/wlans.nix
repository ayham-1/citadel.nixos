{ config, sops-nix, ... }: {
  sops.secrets."wireless.env".neededForUsers = true;
  sops.secrets."wireless.env" = { };

  networking.networkmanager = {
    enable = true;
    ensureProfiles = {
      environmentFiles = [ config.sops.secrets."wireless.env".path ];
      profiles = {
        home-wifi = {
          connection.id = "home-wifi";
          connection.type = "wifi";

          wifi.ssid = "$home_ssid";
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-psk";
            psk = "$home_psk";
          };
        };

        ovgu-wifi = {
          connection.id = "ovgu-wifi";
          connection.type = "wifi";

          wifi.ssid = "$ovgu_ssid";
          wifi.security = "802-11-wireless-security";

          "802-11-wireless-security" = { key-mgmt = "wpa-eap"; };

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
}
