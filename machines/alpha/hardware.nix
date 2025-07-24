{ config, lib, pkgs, modulesPath, nixos-hardware, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-amd-sea-islands
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.grub = {
    enable = true;
    enableCryptodisk = true;
    efiSupport = true;
    efiInstallAsRemovable = false;
    devices = [ "nodev" ]; # UEFI-only boot (no MBR)
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
    options = [ "subvol=root" "noatime" "compress=zstd" "ssd" ];
  };
  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/mapper/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/nix" = {
    device = "/dev/mapper/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = [ "subvol=nix" "noatime" "compress=zstd" "ssd" ];
  };

  fileSystems."/persistent" = {
    device = "/dev/mapper/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = [ "subvol=persistent" "noatime" "compress=zstd" "ssd" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = [ "subvol=home" "noatime" "compress=zstd" "ssd" ];
  };

  fileSystems."/data" = {
    device = "/dev/mapper/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = [ "subvol=data" "noatime" "compress=zstd" "ssd" ];
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
