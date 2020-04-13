#!/bin/bash

eval "FISHER_PATH=$FISHER_PATH"

# fishのインストール
if [ "`type fish`" = "" ]; then
    sudo apt-add-repository -y ppa:fish-shell/release-3
    sudo apt-get update -y
    sudo apt-get install -y fish
fi

# fisherのインストール
if [ ! -e "$FISHER_PATH" ]; then
    curl https://git.io/fisher --create-dirs -sLo $FISHER_PATH
fi

fish -c fisher add jethrokuan/z oh-my-fish/theme-bobthefish jethrokuan/fzf
