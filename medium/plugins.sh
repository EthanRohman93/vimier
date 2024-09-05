#!/bin/bash

# Remove existing ~/.vim/bundle
echo "Removing existing $HOME/.vim/bundle directory..."
rm -rf $HOME/.vim/bundle
# Create necessary directories for Pathogen
echo "Creating directories for Pathogen..."
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle $HOME/.vim/undodir
# Download and install Pathogen
echo "Downloading and installing Pathogen..."
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# Clone plugins into the $HOME/.vim/bundle directory
echo "Cloning Vim plugins..."
# lsp support
git clone -b release https://github.com/neoclide/coc.nvim $HOME/.vim/bundle/coc.nvim
# color scheme
git clone https://github.com/ayu-theme/ayu-vim.git $HOME/.vim/bundle/ayu-vim
# lightline.vim
git clone https://github.com/itchyny/lightline.vim.git $HOME/.vim/bundle/lightline.vim
# vim-commentary
git clone https://github.com/tpope/vim-commentary.git $HOME/.vim/bundle/vim-commentary
# undo tree 
git clone https://github.com/mbbill/undotree.git $HOME/.vim/bundle/undotree
# Confirmation message
echo "Vim environment setup complete!"
