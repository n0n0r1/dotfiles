#!/bin/bash

curl https://sh.rustup.rs -sSf | sh

fish -c 'set -Ux fish_user_paths $HOME/.cargo/bin $fish_user_paths'