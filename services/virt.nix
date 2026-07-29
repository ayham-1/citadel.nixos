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

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["ayham"];
  nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    distrobox
    swtpm
  ];
}
