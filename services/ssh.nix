{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ openssh ];
}
