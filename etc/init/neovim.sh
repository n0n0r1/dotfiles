#!/bin/bash

sudo apt install neovim

if [ -z "$(type python > /dev/null 2>&1)" ]; then
    sudo apt install python-neovim
else
    echo "please install python"
fi
