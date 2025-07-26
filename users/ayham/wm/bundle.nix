{ lib, ... }: {
  imports = [
    ./sway.nix

    ./bars/bundle.nix
  ];

  # set defaults to select window manager
  citadel.users.wm.sway.enable = lib.mkDefault true;


  # set defaults to select bar
  citadel.users.wm.bars.waybar.enable = lib.mkDefault true;
}
