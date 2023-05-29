#!/usr/bin/sh

NEOVIM=~/.config/nvim
export NEOVIM

rm -rf "$NEOVIM"

mkdir -p "$NEOVIM"

cp -r ./. $NEOVIM
