{pkgs, ...}: {
  environment.systemPackages = with pkgs; [imagemagick];
  home-manager.users.ayham = {pkgs, ...}: {
    programs.foot = {
      enable = true;
      server.enable = true;
    };
  };
}
