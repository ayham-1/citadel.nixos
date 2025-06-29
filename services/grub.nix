{ config, lib, ... }: 
{
  boot.loader = {
    timeout = lib.mkDefault 2;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      enableCryptodisk = true;
      efiSupport = true;
      device = "nodev";
      memtest86.enable = lib.mkDefault false;
      gfxmodeEfi = "1024x768";
    };
  };
}
