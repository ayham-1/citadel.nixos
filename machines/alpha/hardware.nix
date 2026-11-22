{
  config,
  lib,
  modulesPath,
  nixos-hardware,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-amd-sea-islands
    nixos-hardware.nixosModules.common-pc-ssd

    ../common/disk-encrypted-uefi.nix
  ];

  citadel.disk.encrypted.uefi = {
    enable = true;
    device = "/dev/sda";
  };

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [
    "amdgpu"
  ];
  boot.kernelParams = ["amd_iommu=on"];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkForce "performance";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
