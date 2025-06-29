{ config, pkgs, lib, ... }: {
  virtualisation.libvirtd = {
    enable = true;
    socketActivated = true;
  };
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    qemu_full
  ];
}
