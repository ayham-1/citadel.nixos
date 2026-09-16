{
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = with pkgs; [imagemagick];
  home-manager.users.${username} = {pkgs, ...}: {
    programs.foot = {
      enable = true;
      server.enable = true;
    };
  };
}
