{
  config,
  lib,
  pkgs,
  modulesPath,
  nixos-hardware,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-amd-sea-islands
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"

    "amdgpu" # replace or remove with your device's driver as needed
  ];
  boot.kernelParams = ["amd_iommu=on" "vfio-pci.ids=8086:095a"];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.grub = {
    enable = true;
    enableCryptodisk = true;
    efiSupport = true;
    efiInstallAsRemovable = false;
    devices = ["nodev"]; # UEFI-only boot (no MBR)
  };

  boot.initrd.luks.devices = {
    boot = {
      device = "/dev/sda2";
      allowDiscards = true;
    };

    root = {
      device = "/dev/sda3";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems."/efi" = {
    device = "/dev/sda1";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/mapper/root";
    fsType = "btrfs";
    options = ["subvol=root" "noatime" "compress=zstd" "ssd"];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = ["subvol=nix" "noatime" "compress=zstd" "ssd"];
  };

  fileSystems."/persistent" = {
    device = "/dev/mapper/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = ["subvol=persistent" "noatime" "compress=zstd" "ssd"];
  };

  fileSystems."/data" = {
    device = "/dev/mapper/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = ["subvol=data" "noatime" "compress=zstd" "ssd"];
  };

  fileSystems."/boot" = {
    device = "/dev/mapper/boot";
    fsType = "ext4";
    options = ["defaults"];
  };
  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.eno1.useDHCP = lib.mkForce true;
  networking.interfaces.wlan0.useDHCP = lib.mkForce false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
