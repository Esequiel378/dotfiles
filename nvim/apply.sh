#!/usr/bin/sh

NVIM=~/.config/nvim

rm -rf $NVIM
mkdir -p $NVIM

cp -r . $NVIM
