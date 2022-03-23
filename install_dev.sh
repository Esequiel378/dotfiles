#!/usr/bin/sh

NVIM_V2=~/.config

SHARE=$NVIM_V2/share
NVIM=$NVIM_V2/nvim

export NVIM_V2

rm -rf $NVIM $SHARE

mkdir -p $NVIM
mkdir -p $SHARE

stow --restow --target=$NVIM .

alias nvi='XDG_DATA_HOME=$SHARE XDG_CONFIG_HOME=$NVIM nvim'
export nvi
