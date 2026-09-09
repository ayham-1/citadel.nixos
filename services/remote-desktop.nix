{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    citadel.remote.server.enable = lib.mkEnableOption "Citadel: Remote Desktop Server";
  };

  config = {
    services.xserver = lib.mkIf config.citadel.remote.server.enable {
      enable = true;
      displayManager.startx.enable = true;
      windowManager.icewm.enable = true;
    };

    services.xrdp = lib.mkIf config.citadel.remote.server.enable {
      enable = true;
      defaultWindowManager = "icewm-session";
      openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      tigervnc
      remmina
    ];
  };
}
