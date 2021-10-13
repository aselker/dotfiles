#!/usr/bin/bash

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt install fish neovim

mkdir -p .config/fish
ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish
mkdir -p .config/nvim/
ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
