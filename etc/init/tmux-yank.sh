#!/bin/bash

set -x
eval "TMUX_YANK_PATH=$TMUX_YANK_PATH"

# dependencies
sudo apt install -y xsel

git clone https://github.com/tmux-plugins/tmux-yank $TMUX_YANK_PATH

if [ -z "$(cat ~/.tmux.conf | grep run-shell | grep yank.tmux)" ]; then
    echo -e 'run-shell $TMUX_YANK_PATH/yank.tmux' >> ~/.tmux.conf
    echo -e 'set -U TMUX_YANK_PATH $HOME/.tmux-yank' >> ~/.config/fish/config.fish
fi
