#!/bin/bash

eval "FZF_PATH=$FZF_PATH"

sudo apt-get install -y git unzip connect-proxy

# fzfのインストール
if [ -z "$(command -v fzf)" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZF_PATH
    $FZF_PATH/install
fi
