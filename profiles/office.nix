{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    obsidian 
    libreoffice-fresh 

    texliveFull
    zathura
  ];
}
