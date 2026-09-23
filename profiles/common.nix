{
  config,
  pkgs,
  sops-nix,
  lib,
  ...
}: {
  imports = [
    sops-nix.nixosModules.sops
  ];

  options = {
    citadel.allowedUnfree = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Citadel: List of unfree package names allowed by active modules.";
    };
  };

  config = {
    # initial root password
    sops.secrets."users/root/password".neededForUsers = true;
    users.users.root.hashedPasswordFile = config.sops.secrets."users/root/password".path;

    # mount tmpfs on /tmp
    boot.tmp.useTmpfs = true;

    # centrally manage users
    users.mutableUsers = false;

    # install basic packages
    environment.systemPackages = with pkgs; [
      usbutils
      htop
      iotop
      iftop
      killall
      wget
      curl
      tcpdump
      nettools
      whois
      file
      lsof
      inotify-tools
      strace
      xz
      lz4
      zip
      unzip
      rsync
      tealdeer
      cheat
      tmux
      tree
      dfc
      pwgen
      mkpasswd
      jq
      git
      pass
      macchanger
      vim
      neovim
      gnupg
      sops
      age
      ssh-to-age
      nixos-anywhere
      disko
      nh
      sshfs
    ];

    programs.bash.completion.enable = true;
    programs.zsh.enableCompletion = true;

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) config.citadel.allowedUnfree;
  };
}
