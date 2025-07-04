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
      defaultKeymap = "viins";
      autocd = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "thefuck" "gpg-agent" "shrink-path" ];
      };
      shellAliases = {
        myip = "curl ipinfo.io/ip";
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
        ide = "nix run --refresh github:ayham-1/ide";
      };
      loginExtra = "
        bindkey -v
      ";
      history.size = 10000;
    };
  };
}
