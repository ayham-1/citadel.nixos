{ config, pkgs, lib, ... }: {
  home-manager.users.ayham = { pkgs, ... }: {
    programs.tmux = {
      enable = true;
      terminal = "xterm-kitty";
      shell = "${pkgs.zsh}/bin/zsh";
      prefix = "C-a";
      mouse = true;
      baseIndex = 1;
      escapeTime = 0;
      keyMode = "vi";
      sensibleOnTop = false;
      aggressiveResize = false;

      plugins = with pkgs.tmuxPlugins; [ sensible sessionist pain-control ];

      extraConfig = ''
        # Disable bells
        set-option -g bell-action none
        set-option -g visual-bell off
        set-option -g visual-activity off

        # Send prefix with C-a
        bind-key C-a send-prefix

        # Window titles
        set -g set-titles on
        set -g set-titles-string '#S@#T #I:#W'

        # Split panes with | and -
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # Pane navigation with Alt + arrow keys
        bind -n M-h select-pane -L
        bind -n M-l select-pane -R
        bind -n M-k select-pane -U
        bind -n M-j select-pane -D

        # Rename windows
        set-option -g allow-rename on
        bind-key r command-prompt -I "#W" "rename-window '%%'"

        # Highlight activity
        setw -g monitor-activity on

        # Support image.nvim passthrough
        set -gq allow-passthrough on

        # Resize panes faster with Shift + arrow keys
        bind C-S-h resize-pane -L 10
        bind C-S-l resize-pane -R 10
        bind C-S-k resize-pane -U 10
        bind C-S-j resize-pane -D 10

        # Swap windows with Ctrl+Shift+arrow
        bind-key -n C-S-Left swap-window -t -1
        bind-key -n C-S-Right swap-window -t +1

        # Renumber windows after closing one
        set-option -g renumber-windows on

        # TPM bootstrap (first-time install)
        if "test ! -d ~/.tmux/plugins/tpm" \
          "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"

        # Initialize TPM (keep last)
        run -b '~/.tmux/plugins/tpm/tpm'
      '';
    };
  };
}
