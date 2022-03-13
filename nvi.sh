#!/usr/bin/sh

NVIM_V2=~/.config/nvim-v2
export NVIM_V2

alias nvi='XDG_DATA_HOME=$NVIM_V2/share XDG_CONFIG_HOME=$NVIM_V2 nvim'
export nvi

nvi
