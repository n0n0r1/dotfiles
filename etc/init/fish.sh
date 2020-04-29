#!/bin/bash

eval "FISHER_PATH=$FISHER_PATH"

# fishのインストール
if [ -z "$(command -v fish)" ]; then
    sudo apt-add-repository -y ppa:fish-shell/release-3
    sudo apt update -y
    sudo apt install -y fish
fi

# fisherのインストール
if fish -c fisher >/dev/null 2>&1; then
    curl https://git.io/fisher --create-dirs -sLo $FISHER_PATH
    fish -c fisher add jethrokuan/z oh-my-fish/theme-bobthefish jethrokuan/fzf
fi

