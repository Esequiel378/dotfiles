#!/usr/bin/sh

NVIM_V2=~/.config/nvim-v2
export NVIM_V2

rm -rf $NVIM_V2

mkdir -p $NVIM_V2/share
mkdir -p $NVIM_V2/nvim

stow --restow --target=$NVIM_V2/nvim .

alias nvi='XDG_DATA_HOME=$NVIM_V2/share XDG_CONFIG_HOME=$NVIM_V2 nvim'
export nvi
