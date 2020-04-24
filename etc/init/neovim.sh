#!/bin/bash

if [ -z "$(command -v nvim)" ]; then
    sudo apt install -y neovim
fi

if [ ! -z "$(command -v python)" ]; then
    sudo apt install -y python-neovim
else
    echo "please install python"
fi
