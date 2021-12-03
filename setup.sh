#!/usr/bin/bash

# TODO:
# * Bashrc is not perfect, might have two copies of the "don't do anything"
# * LADSPA setup
# * Wallpaper
# * Symlink the rest of the config files
# * List firefox addons
# * Small scripts
# * brightnessctl setuid or something?

# Stuff this won't do:
# * Firefox addons

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

# Syncthing repo
sudo curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing

# Signal repo
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" |   sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
wget -O- https://updates.signal.org/desktop/apt/keys.asc |\
  sudo apt-key add -

sudo apt update
sudo apt install fish neovim exuberant-ctags syncthing signal-desktop cargo brightnessctl pavucontrol keepassxc compton feh
pip3 install black

# Alacritty
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo install alacritty
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.cargo/bin/alacritty 50

cargo install ripgrep

mkdir -p ~/.config/fish
ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish
mkdir -p ~/.config/nvim/
ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
