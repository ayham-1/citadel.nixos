{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.libvirtd = {enable = true;};
  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    distrobox
    swtpm
  ];
}
