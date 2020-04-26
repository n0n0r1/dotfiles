#!/bin/bash

eval "TMUX_PATH=$TMUX_PATH"

if [ -z "$(command -v tmux)" ]; then
    # dependencies
    sudo apt-get install -y git automake bison build-essential pkg-config libevent-dev libncurses5-dev

    trap "rm -rf $TMUX_PATH" EXIT
    git clone https://github.com/tmux/tmux $TMUX_PATH

    cd $TMUX_PATH
    ./autogen.sh
    ./configure --prefix=/usr/local
    make
    sudo make install
    tmux -V
fi

if [ -z "$(command -v win32yank.exe)" ]; then
    curl -LO https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    unzip -d $(wslpath -u "$USERPROFILE")/$WINDOWS_PATH_DIR win32yank-x64.zip
fi