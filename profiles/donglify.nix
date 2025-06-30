{ pkgs, ... }: {
  # This is to be added for all systems that want to be support donglify
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    copyKernels = true;
    devices = [ "nodev" ];
  };

  environment.systemPackages = with pkgs; [ grub2 ];
}
