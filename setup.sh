#!/usr/bin/bash

# Set up a new machine.  I do not recommend running this!  It's more of a reference.

# TODO:
# * LADSPA setup, maybe
# * Symlink the rest of the config files
# * List firefox addons
# * Small scripts, and symlink ocr_cp etc. to ~/.local/bin
# * brightnessctl setuid or something?  This might depend on the hardware
# * Replace fish-in-bashrc with chsh like normal.  Or not, chsh doesn't seem to work on Joby machines.
# * Fix adding the fish thing to the top of .bashrc.  It duplicates the first bit that makes the bashrc not do anything if not interactive, and also the string is embedded incorrectly in this script.
# * Make sure this is still correct for Ubuntu 22.10 and beyond
# 	* Syncthing repo still necessary?
# 	* Signal repo

# Stuff this won't do:
# * Firefox addons
# * Wallpaper files
# * Syncthing setup, since other computers need to add the new one
# * Copy xorg.conf.d files

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
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

sudo apt update
sudo apt install fish neovim syncthing signal-desktop cargo brightnessctl pavucontrol keepassxc compton feh tesseract-ocr i3-wm
pip3 install black

# Alacritty
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo install alacritty
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.cargo/bin/alacritty 50

cargo install ripgrep

mkdir -p ~/.config/fish
ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config/i3
ln -s ~/.dotfiles/config.i3 ~/.config/i3/config
ln -s ~/.dotfiles/mem.sh ~/.config/i3/mem.sh
mkdir -p ~/.config/i3status
ln -s ~/.dotfiles/config.i3status ~/.config/i3status/config
mkdir -p ~/.config/alacritty
ln -s ~/.dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ~/.dotfiles/Xresources ~/.Xresources

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
