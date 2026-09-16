{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  options = {
    citadel.users.browsers.brave.enable = lib.mkEnableOption "Citadel: Enables librewolf userconfig";
  };

  config = lib.mkIf config.citadel.users.browsers.brave.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [brave];
    };
  };
}
