{ inputs, outputs, lib, config, pkgs, ... }: {
  home = {
    username = "ayham";
    homeDirectory = "/home/ayham";
    stateVersion = "25.05";
  };
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

  # TODO(ayham-1): maybe someday have an impermenant home
  #imports = [ impermanence.homeManagerModules.impermanence ];

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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  services.network-manager-applet.enable = true;
}
