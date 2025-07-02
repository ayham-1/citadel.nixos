{ pkgs, ... }: {
  # This is to be added for all systems that want to be support donglify
  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    efiInstallAsRemovable = false;
    copyKernels = true;
    forceInstall = false;
    devices = [ "nodev" ];
  };

  environment.systemPackages = with pkgs; [ grub2 ];
}
