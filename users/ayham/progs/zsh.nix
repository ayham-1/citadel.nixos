{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    history = {
      size = 100;
      save = 100;
      path = "/dev/null";
    };

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
    };

    dotDir = ".config/zsh";

    plugins = [{
      name = "shrink-path";
      src = pkgs.oh-my-zsh;
      file = "plugins/shrink-path/shrink-path.plugin.zsh";
    }];

    oh-my-zsh = {
      enable = true;
      plugins = [ "shrink-path" ];
    };

    initExtraBeforeCompInit = ''
      autoload -U colors && colors
      setopt autocd
      stty stop undef
      setopt interactive_comments
    '';

    initExtraFirst = ''
      bindkey -v
      export KEYTIMEOUT=1
      bindkey -v '^?' backward-delete-char

      function zle-keymap-select {
        case $KEYMAP in
          vicmd) echo -ne '\e[1 q';;
          viins|main) echo -ne '\e[5 q';;
        esac
      }

      zle -N zle-keymap-select

      function zle-line-init {
        zle -K viins
        echo -ne "\e[5 q"
      }

      zle -N zle-line-init
      echo -ne "\e[5 q"

      preexec() { export GPG_TTY=$(tty); echo -ne '\e[5 q'; }

      autoload edit-command-line; zle -N edit-command-line
      bindkey '^e' edit-command-line
      bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
    '';

    promptInit = ''
      setopt prompt_subst
      PROMPT='(%n@%m) [$(shrink_path -f)] > '
    '';
  };

  home-manager.users.ayham = { pkgs, ... }: {
    home.packages = with pkgs; [ fzf gnupg z oh-my-zsh ];
  }
}
