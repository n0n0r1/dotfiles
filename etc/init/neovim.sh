#!/bin/bash

if [ -z "$(command -v nvim)" ]; then
    sudo apt install -y neovim
fi

if [ ! -z "$(command -v python)" -a -z "$(pip list | grep pynvim)" ]; then
    pip install pynvim
fi
