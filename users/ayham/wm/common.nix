{pkgs, ...}: {
  home-manager.users.ayham = {
    xdg.portal = {
      enable = true;
      configPackages = [pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-wlr];
      extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome];
    };

    services.flameshot = {
      enable = true;
      settings = {
        General = {
        };
      };
    };

    programs.swaylock.enable = true;
    services.mako.enable = true;
    services.swayidle = {
      enable = true;
      events.lock = "swaylock";
    };
  };
}
