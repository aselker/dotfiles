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

sudo curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing

sudo apt install fish neovim exuberant-ctags syncthing signal-desktop
pip3 install black

mkdir -p .config/fish
ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish
mkdir -p .config/nvim/
ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
