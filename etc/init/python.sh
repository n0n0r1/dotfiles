#!/bin/bash

eval "PYENV_PATH=$PYENV_PATH"
eval "PYTHON_VERSION=$PYTHON_VERSION"

# dependencies
sudo apt-get update; sudo apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# pyenvのインストール
if [ ! -e "$PYENV_PATH" ]; then
    git clone https://github.com/pyenv/pyenv.git $PYENV_PATH
fi

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

if [ ! -z "$(type bash > /dev/null 2>&1)" -a -z "$(grep PYENV_ROOT ~/.bashrc)" ]; then
    echo '' >> ~/.bashrc
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
fi

if [ ! -z "$(type zsh > /dev/null 2>&1)" -a -z "$(grep PYENV_ROOT ~/.zshrc)" ]; then
    echo '' >> ~/.zshrc
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
fi

if [ ! -z "$(type fish > /dev/null 2>&1)" -a -z "$(echo $PYENV_ROOT)" ]; then
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths
    echo -e 'if command -v pyenv 1>/dev/null 2>&1\n    pyenv init - | source\nend' >> ~/.config/fish/config.fish
fi