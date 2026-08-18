{
  config,
  lib,
  pkgs,
  home-manager,
  stylix,
  ...
}: {
  options = {
    citadel.users.wm.niri.enable = lib.mkEnableOption "citadel: enables niri userconfig";
  };

  config = lib.mkIf config.citadel.users.wm.niri.enable {
    home-manager.users.ayham = {
    };
  };
}
