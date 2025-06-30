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

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
