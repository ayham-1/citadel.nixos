{...}: {
  flake.citadel.modules.core.locale = {...}: {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = "all";
    };

    console = {
      keyMap = "us";
    };

    time = {
      timeZone = "Europe/Berlin";
    };
  };
}
