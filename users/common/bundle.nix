{
  config,
  pkgs,
  home-manager,
  username,
  niri,
  ...
}: {
  imports = [
    ./progs/bundle.nix
    ./wm/bundle.nix

    ./browsers/bundle.nix

    ./impermanence.nix
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
  };
  programs.zsh.enable = true;

  environment.systemPackages = [home-manager];

  services.printing.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = null;

  home-manager.sharedModules = [
    niri.homeModules.niri
  ];

  home-manager.users.${username} = {
    home = {
      username = "${username}";
      homeDirectory = "/home/${username}";
      stateVersion = "26.05";
    };
    programs.home-manager.enable = true;

    # set up xdg variables
    xdg.enable = true;
    xdg.userDirs.enable = true;
    xdg.userDirs.desktop = "$HOME/desk";
    xdg.userDirs.documents = "$HOME/dox";
    xdg.userDirs.download = "$HOME/.cache/dl";
    xdg.userDirs.extraConfig = {XDG_MISC_DIR = "$HOME/misc";};
    xdg.userDirs.music = "$HOME/muz";
    xdg.userDirs.pictures = "$HOME/pix";
    xdg.userDirs.publicShare = "$HOME/pub";
    xdg.userDirs.templates = "$HOME/templ";
    xdg.userDirs.videos = "$HOME/vidz";

    # gtk theme
    gtk = {enable = true;};
    # qt theme
    qt = {enable = true;};

    # mime types
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = ["zathura.desktop"];
      "image/*" = ["sxiv.desktop"];
      "video/png" = ["mpv.desktop"];
      "video/jpg" = ["mpv.desktop"];
      "video/*" = ["mpv.desktop"];
      "image/png" = ["sxiv.desktop"];
      "image/jpeg" = ["sxiv.desktop"];
      "image/gif" = ["sxiv.desktop"];
      "image/webp" = ["sxiv.desktop"];
      "image/bmp" = ["sxiv.desktop"];
      "image/tiff" = ["sxiv.desktop"];
    };

    xdg.mimeApps.associations.added = {
      "image/png" = ["sxiv.desktop"];
      "image/jpeg" = ["sxiv.desktop"];
      "image/gif" = ["sxiv.desktop"];
      "image/webp" = ["sxiv.desktop"];
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
    services.network-manager-applet.enable = true;
  };
}
