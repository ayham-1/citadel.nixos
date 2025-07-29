{ config, pkgs, lib, home-manager, ... }: {
  home-manager.users.ayham = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      extraLuaConfig = builtins.readFile ./nvim.lua;
      defaultEditor = true;
      extraPackages = with pkgs; [ 
        lua
        luajit
        luajitPackages.luarocks_bootstrap
        luajitPackages.luarocks-nix
        ripgrep
        fd
      ];
    };
    programs.neovide.enable = true;
  };
}
