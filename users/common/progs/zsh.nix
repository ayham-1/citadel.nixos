{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = ["completion" "history"];
    };
    syntaxHighlighting.enable = true;
    autocd = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo" "gpg-agent" "shrink-path" "vi-mode"];
    };
    shellAliases = {
      myip = "curl ipinfo.io/ip";
      ll = "ls -al";
    };
    history.size = 10000;
  };

  home.packages = with pkgs; [
    fzf
    oh-my-zsh
  ];
}
