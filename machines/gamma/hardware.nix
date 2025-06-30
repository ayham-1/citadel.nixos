{ config, lib, pkgs, modulesPath, nixos-hardware, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  boot.loader.grub = {
    enable = true;
    copyKernels = true;
    devices = [ ];
  };

  boot.initrd.luks.devices = {
    boot = { device = "/dev/sda1"; };

    root = {
      device = "/dev/sda2";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/mapper/root";
    fsType = "btrfs";
    options = [ "subvol=@" "noatime" "compress=zstd" "ssd" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/root";
    fsType = "btrfs";
    options = [ "subvol=@home" "noatime" "compress=zstd" "ssd" ];
  };

  fileSystems."/data" = {
    device = "/dev/mapper/root";
    fsType = "btrfs";
    options = [ "subvol=@data" "noatime" "compress=zstd" "ssd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/mapper/boot";
    fsType = "ext4";
    options = [ "defaults" ];
  };
  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
