#!/bin/bash

# Run vim plugin install
./plugins.sh
# Run fzf install
./fuzzy_install.sh
# Copy .bashrc
cp .bashrc $HOME/.bashrc
# Copy .vimrc
cp .vimrc $HOME/.vimrc
# Copy gpt file
cp gpt.py $HOME/gpt.py
# compile main
gcc main.c -o $HOME/main
# copy main
cp main $HOME/main
