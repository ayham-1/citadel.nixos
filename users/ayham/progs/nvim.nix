{ config, pkgs, lib, home-manager, nvf, ... }: {
  programs.nvf = {
    enable = true;
    settings = import ./nvf.nix;
    enableManpages = true;
  };
  home-manager.users.ayham = { pkgs, ... }: { programs.neovide.enable = true; };
}
