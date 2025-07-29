{ config, lib, home-manager, pkgs, ... }:
let
  user = "ayham";
  xinit = "${pkgs.xorg.xinit}/bin/xinit";
  xvnc = "${pkgs.tigervnc}/bin/Xvnc";
  vncserver = "${pkgs.tigervnc}/bin/vncserver";
  xstartup = "/home/${user}/.vnc/xstartup";
in {
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable =
    true; # enables `.xsession` launching
  services.xserver.windowManager.icewm.enable = true;

  services.xrdp = {
    enable = true;
    defaultWindowManager = "icewm-session"; # change if you want something else
  };
  environment.systemPackages = with pkgs; [
    icewm
    tigervnc
    xterm
    xorg.xinit
    xrdp
  ];

  home-manager.users.ayham = { pkgs, ... }: {
    home.file.".vnc/xstartup" = {
      text = ''
        #!/bin/sh
        exec icewm-session
      '';
      executable = true;
    };
  };
}
