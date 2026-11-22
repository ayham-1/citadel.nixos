{self, ...}: {
  flake.citadel.modules.core = {
    pkgs,
    sops-nix,
    ...
  }: let
    modules = with self.citadel.modules.core; [
      motd
      users
      nix-settings
      locale
    ];
  in {
    imports = [sops-nix.nixosModules.sops] ++ modules;

    boot.tmp.useTmpfs = true;

    programs.bash.completion.enable = true;
    programs.zsh.enableCompletion = true;

    environment.systemPackages = with pkgs; [
      age
      btop
      cheat
      curlWithGnuTls
      dfc
      disko
      file
      gvfs
      htop
      iftop
      inotify-tools
      iotop
      jq
      killall
      libnotify
      lsof
      lz4
      macchanger
      mkpasswd
      neovim
      nettools
      nh
      nixos-anywhere
      p7zip-rar
      pass
      pwgen
      rsync
      sops
      ssh-to-age
      sshfs
      strace
      tcpdump
      tealdeer
      tmux
      tree
      unzip
      usbutils
      vim
      wget
      whois
      xz
      zip
    ];

    # common sops config
    sops = {
      defaultSopsFile = "/persistent/etc/sops/secrets.yaml";
      defaultSopsFormat = "yaml";
      validateSopsFiles = false;
      age = {
        # needs to be copied into the install machine with the secrets.yaml
        keyFile = "/persistent/etc/sops/keys.txt";
        generateKey = false;
      };
    };

    system = {
      stateVersion = "26.04";

      nixos = {
        variantName = "The Citadel Linux Distro";
      };
    };
  };
}
