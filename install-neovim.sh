#!/bin/bash

set -x

# - Set up environment - #
USER_NAME=$(whoami)
HOME_DIR=$(eval echo ~$USER_NAME)
STABLE_VERSION="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
INSTALL_DIR="$HOME_DIR/.local/neovim"
CONFIGS="https://github.com/P81000/Masteguin.Neovim.git"
CONFIG_DIR="$HOME_DIR/.config/nvim"
LOCAL_BIN="$HOME_DIR/.local/bin"

# - Install Neovim - #
if [ ! -x "$LOCAL_BIN/nvim" ]; then
    mkdir -p $INSTALL_DIR
    mkdir -p $LOCAL_BIN
    curl -o $INSTALL_DIR/nvim-linux64.tar.gz -LO $STABLE_VERSION
    tar xzvf $INSTALL_DIR/nvim-linux64.tar.gz -C $INSTALL_DIR
    ln -s $INSTALL_DIR/nvim-linux64/bin/nvim $LOCAL_BIN/nvim
    PATH="$LOCAL_BIN:$PATH"
else
    echo "Neovim is already installed"
fi

# - Config - #
git clone $CONFIGS $CONFIG_DIR

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

find $CONFIG_DIR -type f -name "*.lua" -exec nvim --headless -s -c "source {}" > /dev/null 2>&1 \;

timeout=5
timeout $timeout nvim --headless -S $CONFIG_DIR/lua/masteguin/packer.lua -c 'lua require("packer").sync()'

nvim -c 'q'

echo "Neovim config completed!"
