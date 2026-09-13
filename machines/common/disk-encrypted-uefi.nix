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
          canTouchEfiVariables = false;
        };

        grub = {
          enable = true;
          enableCryptodisk = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          devices = ["nodev"];
        };
      };
    };

    fileSystems = {
      "/".neededForBoot = true;
      "/persistent".neededForBoot = true;
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
              cryptboot = {
                size = "2G";
                content = {
                  type = "luks";
                  name = "cryptboot";

                  extraFormatArgs = ["--type" "luks1"];

                  passwordFile = "/tmp/secret.boot.key";

                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/boot";
                  };
                };
              };
              cryptroot = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "cryptroot";

                  settings = {
                    allowDiscards = true;
                  };

                  passwordFile = "/tmp/secret.root.key";

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
