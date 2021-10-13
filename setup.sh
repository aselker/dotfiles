#!/usr/bin/bash

echo "# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Start Fish instead, unless starting from a fish cmd line, or as a single-line command (e.g. "bash -c 'echo test'")
if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi" | cat - ~/.bashrc > /temp/bashrc && mv /temp/bashrc .bashrc

sudo apt install fish neovim

mkdir -p .config/fish
ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish
mkdir -p .config/nvim/
ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
