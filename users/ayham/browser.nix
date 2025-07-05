{ config, pkgs, lib, home-manager, stylix, ... }: {
  home-manager.users.ayham = {
    programs.librewolf = {
      enable = true;
      nativeMessagingHosts = [ pkgs.tridactyl-native ];

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
        "browser.tabs.inTitlebar" = 0;
        "sidebar.verticalTabs" = true;
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;
        "browser.tabs.firefox-view" = false;
        #"app.normandy.first_run" = false;
        #"browser.ctrlTab.recentlyUsedOrder" = false;
        #"browser.link.open_newwindow" = true;
        #"browser.urlbar.suggest.calculator" = true;

        "browser.urlbar.quickactions.enabled" = false;
        "browser.urlbar.quickactions.showPrefs" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.discovery.enabled" = false;

        "toolkit.telemetry.enabled"= false;
        "toolkit.telemetry.unified"= false;
        "toolkit.telemetry.archive.enabled"= false;
        "toolkit.telemetry.newProfilePing.enabled"= false;
        "toolkit.telemetry.shutdownPingSender.enabled"= false;
        "toolkit.telemetry.updatePing.enabled"= false;
        "datareporting.healthreport.uploadEnabled"= false;
        "app.shield.optoutstudies.enabled"= false;
      };

      policies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        HardwareAcceleration = true;
        TranslateEnabled = true;
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;
        ExtensionUpdate = true;

        FirefoxHome = {
          Search = false;
          TopSites = false;
          SponsoredPocket = false;
          Pocket = false;
          Snippets = false;
          SponsoredTopSites = false;
          Highlights = false;
        };

        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
        };

        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
          WhatsNew = false;
          UrlbarInterventions = false;
          MorFromMozilla = false;
          FeatureRecommendations = false;
          Locked = true;
        };
        UseSystemPrintDialog = true;

        Preferences = {
          "sidebar.verticalTabs" = true;
          "browser.tabs.inTitlebar" = 0;
        };

        ExtensionSettings = {
          "@*" = {
            installation_mode = "allow";
            default_area = "navbar";
            blocked_install_message = "Extensions are managed by The Citadel";
          };
        };

        SearchSuggestEnabled = false;

        SanitizeOnShutdown = {
          Cache = true;
          Cookies = false;
          Downlaods = true;
          FormData = true;
          History = true;
          Sessions = true;
          SiteSettings = true;
          OfflineApps = true;
          Locked = true;
        };

        SearchEngines = {
          PreventInstalls = true;
          Remove = [
            "Amazon.com"
            "Bing"
            "Google"
          ];
          #Default = "DuckDuckGo";
        };
      };

      profiles.lwolf = {
        id = 0;
        name = "lwolf";
        isDefault = true;

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          sponsorblock
          return-youtube-dislikes
          enhanced-h264ify
          user-agent-string-switcher
          vimium
          clearurls
          duckduckgo-privacy-essentials
          privacy-badger
          unpaywall
          terms-of-service-didnt-read
          steam-database
          augmented-steam
        ];
      };
    };

    stylix.targets.librewolf.profileNames = [ "lwolf" ];
    stylix.targets.firefox.profileNames = [ "lwolf" ];

    # Brave installation and config
    home.packages = with pkgs; [ brave ];
  };
}
