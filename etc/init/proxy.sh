#!/bin/bash

sudo apt install -y connect-proxy

if [ -z "$(grep set_proxy ~/.config/fish/config.fish)" ]; then
    echo "set_proxy" >> ~/.config/fish/config.fish
fi