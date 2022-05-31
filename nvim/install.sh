#!/usr/bin/sh

NVIM=~/.config/nvim

rm -rf $NVIM
mkdir -p $NVIM

stow --restow --target=$NVIM .

