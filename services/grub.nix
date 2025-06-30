{ config, lib, ... }: {
  boot.loader = {
    timeout = lib.mkDefault 2;
    grub = { memtest86.enable = lib.mkDefault false; };
  };
}
