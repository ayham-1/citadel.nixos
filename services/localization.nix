{ config, ... }: {
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
  };

  time.timeZone = "Europe/Berlin";
}
