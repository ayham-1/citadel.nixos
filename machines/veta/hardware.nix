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
    nixos-hardware.nixosModules.common-pc-ssd

    ../common/disk-encrypted-uefi.nix
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  networking.useDHCP = lib.mkForce true;
  networking.interfaces.eno1.useDHCP = lib.mkForce true;
  networking.interfaces.wlan0.useDHCP = lib.mkForce true;

  nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkForce "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "suspend";
  };
}
