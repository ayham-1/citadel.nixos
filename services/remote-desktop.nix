{ config, lib, pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.icewm.enable = true;

  services.xrdp = {
    enable = true;
    defaultWindowManager = "icewm-session";
  };
  environment.systemPackages = with pkgs; [
    icewm
    tigervnc
    xterm
    xorg.xinit
    xrdp
    remmina
  ];
}
