{ config, pkgs, lib, ... }: {
  # only import globally essential programs
  imports = [
    <home-manager/nixos>

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

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.ayham = { pkgs, ... }: {
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

    # set up xdg variables
    xdg.enable = true;
    xdg.userDirs.enable = true;
    xdg.userDirs.desktop = "$HOME/desk";
    xdg.userDirs.documents = "$HOME/dox";
    xdg.userDirs.download = "$HOME/.cache/dl";
    xdg.userDirs.extraConfig = { XDG_MISC_DIR = "$HOME/misc"; };
    xdg.userDirs.music = "$HOME/muz";
    xdg.userDirs.pictures = "$HOME/pix";
    xdg.userDirs.publicShare = "$HOME/pub";
    xdg.userDirs.templates = "$HOME/templ";
    xdg.userDirs.videos = "$HOME/vidz";

    # shell
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      shellAliases = {
        myip = "curl ipinfo.io/ip";
        ide = "nix run --refresh github:ayham-1/ide";
      };
    };

    # gtk theme
    gtk = { enable = true; };
    # qt theme
    qt = { enable = true; };

    # mime types
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "image/*" = [ "sxiv.desktop" ];
      "video/png" = [ "mpv.desktop" ];
      "video/jpg" = [ "mpv.desktop" ];
      "video/*" = [ "mpv.desktop" ];
    };
  };
}
