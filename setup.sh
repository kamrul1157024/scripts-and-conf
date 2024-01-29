#!/usr/bin/bash

sudo apt-get update

# Install tmux
sudo apt-get install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#####


# Install NodeJs
cd ~
wget https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz
sudo tar -C /usr/local --strip-components 1 -xvf  node-v20.11.0-linux-x64.tar.xz
#####

# Install neovim
cd ~
npm install -g cspell
sudo apt-get install ripgrep fzf

## Reference https://github.com/neovim/neovim/blob/master/INSTALL.md
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version

# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
#####

##


source ~/scripts-and-conf/sync-config.sh
echo "Install All tmux plugins by running Ctrl-B + I"
echo "Open NeoVim to install plugins"
