{...}: {
  imports = [
    ./kitty.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./vim.nix
    ./tmux.nix
    ./zsh.nix
    ./rofi.nix
    ./fuzzel.nix
    ./fastfetch.nix
    ./foot.nix
    ./kde-connect.nix

    ./obsidian.nix
    ./steam.nix
  ];

  programs.nvf = {
    enable = true;
    settings = import ./../../../services/nvf.nix;
    enableManpages = true;
  };
}
