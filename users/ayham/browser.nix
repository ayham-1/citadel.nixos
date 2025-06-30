{ config, pkgs, lib, home-manager, ... }: {
  home-manager.users.ayham = {
    programs.librewolf = {
      enable = true;
      languagePacks = [ "en-GB" "de" "ar" ];
      settings = {
        "browser.compactmode.enable" = true;
        "browser.contentblocking.category" = "strict";
        "browser.download.panel.shown" = true;
        "browser.newtabpage.enabled" = false;
        "webgl.disable" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "identity.fxaccounts.enabled" = true;
        "network.cookie.lifetimePolicy" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    };

    # Brave installation and config
    home.packages = with pkgs; [ brave ];
  };
}
