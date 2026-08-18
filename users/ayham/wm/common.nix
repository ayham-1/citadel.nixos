{
  config,
  lib,
  pkgs,
  home-manager,
  stylix,
  ...
}: {
  home-manager.users.ayham = {
    xdg.portal = {
      enable = true;
      configPackages = [pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-wlr];
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
    # flameshot
    services.flameshot = {
      # Also installs/enables flameshot
      enable = true;
      settings = {
        General = {
        };
      };
    };
  };
}
