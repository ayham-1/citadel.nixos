{pkgs, ...}: {
  home-manager.users.ayham = {
    xdg.portal = {
      enable = true;
      configPackages = [pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-wlr];
      extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome];
    };

    programs.swaylock.enable = true;
    services.mako.enable = true;
    services.swayidle = let
      cmdlock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    in {
      enable = true;

      events.lock = cmdlock;
      events.before-sleep = cmdlock;
    };
  };
}
