#!/bin/bash

if [ -z "$(command -v npm)" ]; then
    sh node.sh
fi

if [ -z "$(command -v tsc)" ]; then
    sudo npm install -g typescript
fi