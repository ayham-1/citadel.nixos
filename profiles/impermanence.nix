{
  utils,
  pkgs,
  ...
}: {
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      # "/etc/NetworkManager/system-connections" # to save networks permanently
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };

  boot.initrd.systemd = {
    services.wipe-file-systems = {
      description = "wipe-file-systems";

      unitConfig.DefaultDependencies = false;

      serviceConfig = {
        Type = "oneshot";
        StandardOutput = "journal+console";
        StandardError = "journal+console";
      };

      requiredBy = ["initrd.target"];
      before = ["sysroot.mount"];

      requires = ["${utils.escapeSystemdPath "/dev/mapper/root"}.device"];
      after = [
        "${utils.escapeSystemdPath "/dev/mapper/root"}.device"
        "cryptsetup.target"
        "local-fs-pre.target"
      ];

      script = ''
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
    };
    extraBin = {
      "mkdir" = "${pkgs.coreutils}/bin/mkdir";
      "date" = "${pkgs.coreutils}/bin/date";
      "stat" = "${pkgs.coreutils}/bin/stat";
      "mv" = "${pkgs.coreutils}/bin/mv";
      "find" = "${pkgs.findutils}/bin/find";
      "btrfs" = "${pkgs.btrfs-progs}/bin/btrfs";
    };
  };
}
