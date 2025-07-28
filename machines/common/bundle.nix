{ lib, ... }: {
  imports = [
    ./hardware.nix
    ./configuration.nix
  ];
}
