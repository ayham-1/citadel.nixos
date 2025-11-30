{
  config,
  pkgs,
  lib,
  sops-nix,
  ...
}: {
  imports = [
    ../services/grub.nix
    ../services/ntp.nix
    ../services/dns.nix
    ../services/localization.nix

    sops-nix.nixosModules.sops
  ];

  # initial root password
  sops.secrets.root-password.neededForUsers = true;
  users.users.root.hashedPasswordFile = config.sops.secrets.root-password.path;

  # mount tmpfs on /tmp
  boot.tmp.useTmpfs = true;

  # tailscale for all!
  services.tailscale.enable = true;
  #services.tailscale.authKeyParameters.ephemeral = true;
  services.tailscale.authKeyFile = "/root/.tailscale.key";
  networking.firewall.trustedInterfaces = ["tailscale0"];

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
    gnupg
    sops
    age
    ssh-to-age
  ];

  programs.bash.completion.enable = true;
  programs.zsh.enableCompletion = true;
}
