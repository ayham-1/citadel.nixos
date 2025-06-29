{ config, pkgs, ... }: {
  imports = [
    ../../services/localization.nix
    ../../services/fonts.nix
    ../../services/dns.nix
    ../../services/ntp.nix
    ../../services/grub.nix
    ../../services/laptop.nix
    ../../services/ssh.nix
    ../../services/wifi.nix
    ../../services/nix.nix

    ../../profiles/common.nix
    ../../profiles/security.nix
    ../../profiles/development.nix
    ../../profiles/communication.nix

    ../../desktop/common.nix
    ../../desktop/x.nix
    ../../desktop/sound.nix
    ../../desktop/xfce.nix

    ../../users/ayham/base.nix
    ../../users/ayham/browser.nix
    ../../users/ayham/progs/gpg.nix
    ../../users/ayham/progs/git.nix

    <nixos-hardware/common/cpu/intel>
    <nixos-hardware/common/pc/laptop/hdd>
    ./hardware-configuration.nix
  ];

  networking.hostName = "veta";

  boot.initrd.luks.devices."hdd".keyFile = "/keyfile0.bin";
  boot.initrd.secrets = {
    "keyfile0.bin" = "/etc/secrets/initrd/keyfile0.bin";
  };

  system.stateVersion = "23.11";
}
