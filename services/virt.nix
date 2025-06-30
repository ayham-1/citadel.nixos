{ config, pkgs, lib, ... }: {
  virtualisation.libvirtd = { enable = true; };
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    qemu_full
  ];
}
