{ config, pkgs, lib, ... }: {
  imports = [
    ../services/grub.nix
    ../services/ntp.nix
    ../services/dns.nix
    ../services/localization.nix
  ];

  # initial root password
  users.users.root.initialPassword = "nixos";

  # mount tmpfs on /tmp
  boot.tmp.useTmpfs = true;

  # show IP on login screen
  environment.etc."issue.d/ip.issue".text = ''
    \4
  '';

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
    gitAndTools.gitFull
    pass
    macchanger
    vim
    gnupg
  ];

  programs.bash.completion.enable = true;
  programs.zsh.enableCompletion = true;
}
