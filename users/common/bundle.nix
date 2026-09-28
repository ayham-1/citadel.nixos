{
  config,
  pkgs,
  home-manager,
  username,
  niri,
  ...
}: {
  imports = [
    ./wm/bundle.nix

    ./browsers/bundle.nix

    ./impermanence.nix

    ./user-settings.nix
  ];

  sops.secrets."users/${username}/password".neededForUsers = true;

  users.users.${username} = {
    isNormalUser = true; # just making sure
    description = "${username}";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
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
    hashedPasswordFile = config.sops.secrets."users/${username}/password".path;
    shell = pkgs.zsh;

    # TODO: make this optional somehow
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBEuye7nS9bwj75Io0XnlEjyKJvX7g5zmQh2vuI2hVZ2AAAABHNzaDo= yubikey-global-ssh"
    ];
  };

  programs.zsh.enable = true;

  ### NixOS user-specific
  services.pcscd.enable = true;
  services.udev.packages = with pkgs; [
    yubikey-personalization
    libu2f-host
  ];
  hardware.gpgSmartcards.enable = true;

  environment.systemPackages = [home-manager];

  services.printing.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = null;

    sharedModules = [
      niri.homeModules.niri
    ];

    extraSpecialArgs = {inherit username;};
    users.${username} = {
      imports = [./hm-bundle.nix];

      citadel = import ../${username}/configs/native.nix;
    };
  };
}
