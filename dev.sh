#!/bin/sh

tmux new-session -s nixos   -n code -d

tmux new-window  -t nixos:2 -n run
tmux new-window  -t nixos:3 -n build
tmux new-window  -t nixos:4 -n files
tmux new-window  -t nixos:5 -n git

tmux send-keys -t 'code' 'nvim' Enter

tmux send-keys -t 'run' 'ls' Enter

tmux send-keys -t 'build' 'ls' Enter

tmux send-keys -t 'files' 'man tmux' Enter

tmux send-keys -t 'git' 'git log' Enter

tmux select-window -t nixos:1
tmux -2 attach-session -t nixos
