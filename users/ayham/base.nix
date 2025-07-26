{ config, pkgs, lib, home-manager, sops-nix, ... }: {
  imports = [
    ./progs/bundle.nix

    ./progs/zsh.nix
    ./progs/rofi.nix

    ./sway.nix
    ./waybar.nix

    ./browser.nix

    ./secrets.nix
  ];

  sops.secrets.ayham-password.neededForUsers = true;

  users.users.ayham = {
    isNormalUser = true;
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
