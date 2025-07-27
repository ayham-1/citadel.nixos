{ lib, ... }: {
  imports = [
    ./librewolf.nix
    ./brave.nix
  ];

  # default installed browsers
  citadel.users.browsers.librewolf.enable = lib.mkDefault true;
  citadel.users.browsers.brave.enable = lib.mkDefault true;
}
