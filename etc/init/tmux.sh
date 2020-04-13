#!/bin/bash

eval "TMUX_PATH=$TMUX_PATH"

# dependencies
sudo apt install -y git automake bison build-essential pkg-config libevent-dev libncurses5-dev

trap rm -rf $TMUX_PATH EXIT
git clone https://github.com/tmux/tmux $TMUX_PATH

cd $TMUX_PATH
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
tmux -V