{ lib, ... }: {
  imports = [ 
    ./steam.nix
    ./kitty.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./vim.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh.nix
    ./rofi.nix
  ];

  # set defaults of optional Programs
  citadel.users.steam.enable = lib.mkDefault true;
}
