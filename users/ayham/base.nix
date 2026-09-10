{
  config,
  pkgs,
  home-manager,
  ...
}: {
  imports = [
    ./progs/bundle.nix
    ./wm/bundle.nix

    ./browsers/bundle.nix

    ./secrets.nix
    ./impermanence.nix
  ];

  sops.secrets.ayham-password.neededForUsers = true;

  users.users.ayham = {
    isNormalUser = true; # just making sure
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
      "dialout"
      "tty"
    ];
    hashedPasswordFile = config.sops.secrets.ayham-password.path;
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  environment.systemPackages = [home-manager];

  services.printing.enable = true;
}
