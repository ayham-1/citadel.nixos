{ lib, ... }: {
  imports = [ 
    ./steam.nix
    ./kitty.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./vim.nix
    ./tmux.nix
    ./zsh.nix
  ];

  citadel.users.steam.enable = lib.mkDefault true;
}
