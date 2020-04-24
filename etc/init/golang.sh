#!/bin/bash

if [ -z "$(command -v go)" ]; then
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt update
    sudo apt install -y golang-go
fi