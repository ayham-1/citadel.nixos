{
  config,
  lib,
  ...
}: {
  options = {
    citadel.disk.encrypted.uefi = {
      enable = lib.mkEnableOption "Citadel: Encrypted Disk UEFI config";
      device = lib.mkOption {default = "/dev/sda";};
    };
  };

  config = lib.mkIf config.citadel.disk.encrypted.uefi.enable {
    boot = {
      loader = {
        systemd-boot.enable = false;

        efi = {
          efiSysMountPoint = "/efi";
          canTouchEfiVariables = true;
        };

        grub = {
          enable = true;
          enableCryptodisk = true;
          efiSupport = true;
          efiInstallAsRemovable = false;
          devices = ["nodev"];
        };
      };
    };

    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = config.citadel.disk.encrypted.uefi.device;
          content = {
            type = "gpt";
            partitions = {
              EFI = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/efi";
                  mountOptions = ["umask=0077"];
                };
              };
              CRYPTBOOT = {
                size = "2G";
                content = {
                  type = "luks";
                  name = "CRYPTBOOT";

                  extraFormatArgs = ["--type" "luks1"];

                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/boot";
                  };
                };
              };
              CRYPTROOT = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "CRYPTROOT";

                  settings = {
                    allowDiscards = true;
                  };

                  content = {
                    type = "btrfs";
                    extraArgs = ["-f"];
                    subvolumes = {
                      root = {
                        mountpoint = "/";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "ssd"
                        ];
                      };
                      nix = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "ssd"
                        ];
                      };
                      persistent = {
                        mountpoint = "/persistent";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "ssd"
                        ];
                      };
                      data = {
                        mountpoint = "/data";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "ssd"
                        ];
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
