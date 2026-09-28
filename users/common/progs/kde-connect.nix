{
  username,
  lib,
  ...
}: {
  options = {
    citadel.users.${username}.progs.kdeconnect.enable = lib.mkEnableOption "Citadel: enable kde-connect for user";
  };

  config = {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
