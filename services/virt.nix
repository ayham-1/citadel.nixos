{ config, pkgs, lib, ... }: {
  virtualisation.libvirtd = { enable = true; };
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    qemu_full
    distrobox
  ];
}
