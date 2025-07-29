{ config, pkgs, lib, home-manager, sops-nix, ... }: {
  imports = [
    ./progs/bundle.nix
    ./wm/bundle.nix

    ./browsers/bundle.nix

    ./secrets.nix
  ];

  sops.secrets.ayham-password.neededForUsers = true;

  users.users.ayham = {
    isNormalUser = true; # just makingg sure
    home = "/home/ayham";
    description = "ayham";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "docker"
      "libvirtd"
      "scanner"
      "lp"
      "adbusers"
      "seat"
      "input"
      "podman"
    ];
    hashedPasswordFile = config.sops.secrets.ayham-password.path;
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      (builtins.readFile ./keys/id_ayham.pub) # allow self to access self
    ];
  };
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [ home-manager ];

  services.printing.enable = true;
}
