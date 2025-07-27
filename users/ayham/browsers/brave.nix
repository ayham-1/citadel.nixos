{ config, pkgs, lib, home-manager, stylix, ... }: {

  options = {
    citadel.users.browsers.brave.enable = lib.mkEnableOption "Citadel: Enables librewolf userconfig";
  };

  config = lib.mkIf config.citadel.users.browsers.brave.enable {
    home-manager.users.ayham = {
      home.packages = with pkgs; [ brave ];
    };
  };
}
