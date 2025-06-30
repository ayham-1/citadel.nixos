{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
    shellAliases = {
      myip = "curl ipinfo.io/ip";
      ide = "nix run --refresh github:ayham-1/ide";
    };
  };

  environment.systemPackages = with pkgs; [ fzf gnupg oh-my-zsh ];
}
