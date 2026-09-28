{pkgs, ...}: {
  programs.foot = {
    enable = true;
    server.enable = true;
  };
  home.packages = with pkgs; [imagemagick];
}
