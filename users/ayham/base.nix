{ config, pkgs, lib, home-manager, ... }: {
  # only import globally essential programs
  imports = [
    ./progs/kitty.nix
    ./progs/kitty.nix
    ./progs/steam.nix
    ./progs/git.nix
    ./progs/gpg.nix
    ./progs/vim.nix
    ./progs/tmux.nix
    ./progs/zsh.nix

    ./sway.nix
    ./browser.nix
  ];

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
    ];
    initialPassword = "pw123";
  };

  environment.systemPackages = with pkgs; [ home-manager ];

  services.printing.enable = true;
}
