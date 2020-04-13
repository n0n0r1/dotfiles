#!/bin/bash

eval "FZF_PATH=$FZF_PATH"

sudo apt install -y git

# fzfのインストール
if [ ! -d "$FZF_PATH" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZF_PATH
    $FZF_PATH/install
fi
