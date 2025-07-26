{ config, pkgs, home-manager, ... }: {
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [ fzf gnupg oh-my-zsh thefuck ];

  home-manager.users.ayham = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = {
        enable = true;
        strategy = [ "completion" "history" ];
      };
      syntaxHighlighting.enable = true;
      #defaultKeymap = "vicmd";
      autocd = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "thefuck" "gpg-agent" "shrink-path" "vi-mode" ];
      };
      shellAliases = {
        myip = "curl ipinfo.io/ip";
        ll = "ls -al";
        ide = "nix run --refresh github:ayham-1/ide";
      };
      initExtra = ''
        export KEYTIMEOUT=1  # makes ESC response near-instant
      '';
      history.size = 10000;
    };
  };
}
