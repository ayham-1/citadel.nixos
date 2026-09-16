{lib, ...}: {
  imports = [
    ./common.nix

    ./sway.nix
    ./niri.nix

    ./bars/bundle.nix
  ];

  citadel.users.wm.sway.enable = lib.mkDefault true;
  citadel.users.wm.niri.enable = lib.mkDefault true;

  # set defaults to select bar
  citadel.users.wm.bars.waybar.enable = lib.mkDefault true;
}
