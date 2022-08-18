#!/usr/bin/sh

NVIM=~/.config/nvim
TMP=./.tmp

# empty $NVIM folder
rm -rf $NVIM
mkdir -p $NVIM

# copy nvim config to $NVIM folder
cp -r ./nvim/* $NVIM
cp ./stylua.toml $NVIM

rm -rf $TMP
