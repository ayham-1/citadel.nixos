{ config, pkgs, lib, home-manager, stylix, ... }: {
  home-manager.users.ayham = {
    programs.librewolf = {
      enable = true;
      settings = {
        "privacy.resistFingerprinting" = true;
        "privacy.firstparty.isolate" = true;
        "privacy.trackingprotection.enabled" = true;
        "network.cookie.cookieBehavior" = 1; # Block 3rd-party cookies
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "webgl.disabled" = true;
        "dom.security.https_only_mode" = true;
        "extensions.pocket.enabled" = false;
        "media.peerconnection.enabled" = false; # Disable WebRTC
        "geo.enabled" = false;
        "identity.fxaccounts.enabled" = true;
        "browser.safebrowsing.enabled" = false; # Optional: turn off Google Safe Browsing

        "toolkit.telemetry.enabled"= false;
        "toolkit.telemetry.unified"= false;
        "toolkit.telemetry.archive.enabled"= false;
        "toolkit.telemetry.newProfilePing.enabled"= false;
        "toolkit.telemetry.shutdownPingSender.enabled"= false;
        "toolkit.telemetry.updatePing.enabled"= false;
        "datareporting.healthreport.uploadEnabled"= false;
        "app.shield.optoutstudies.enabled"= false;
        };
        };

        stylix.targets.librewolf.profileNames = [ "lwolf" ];
        stylix.targets.firefox.profileNames = [ "lwolf" ];

    # Brave installation and config
    home.packages = with pkgs; [ brave ];
  };
}
