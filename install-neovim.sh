#!/bin/bash

set -x

# - Set up environment - #
USER_NAME=$(whoami)
HOME_DIR=$(eval echo ~$USER_NAME)
STABLE_VERSION="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
INSTALL_DIR="$HOME_DIR/.local/neovim"
CONFIGS="https://github.com/P81000/Masteguin.Neovim.git"
CONFIG_DIR="$HOME_DIR/.config/nvim"

# - Install Neovim - #
if [ ! -x "/bin/nvim" ]; then
    mkdir -p $INSTALL_DIR
    curl -o $INSTALL_DIR/nvim-linux64.tar.gz -LO $STABLE_VERSION
    tar xzvf $INSTALL_DIR/nvim-linux64.tar.gz -C $INSTALL_DIR
    rm -rf $INSTALL_DIR/nvim-linux64.tar.gz
    sudo cp -rv $INSTALL_DIR /bin
    sudo ln -s /bin/neovim/nvim-linux64/bin/nvim /bin/nvim
else
    echo "Neovim is already installed"
fi

# - Config - #
git clone -b test-script --single-branch $CONFIGS $CONFIG_DIR

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

find $CONFIG_DIR -type f -name "*.lua" -exec nvim --headless -s -c "source {}" > /dev/null 2>&1 \;

timeout=5
timeout $timeout nvim --headless -S $CONFIG_DIR/lua/masteguin/packer.lua -c 'lua require("packer").sync()'

nvim -c 'q'

echo "Neovim config completed!"
