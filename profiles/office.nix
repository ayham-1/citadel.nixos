{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libreoffice-fresh

    texliveFull
    zathura
  ];
}
