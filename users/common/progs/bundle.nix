{...}: {
  imports = [
    ./steam.nix
    ./kitty.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./vim.nix
    ./tmux.nix
    ./zsh.nix
    ./rofi.nix
    ./fastfetch.nix
    ./foot.nix
    ./kde-connect.nix
  ];

  programs.nvf = {
    enable = true;
    settings = import ./../../../services/nvf.nix;
    enableManpages = true;
  };
}
