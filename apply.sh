#!/usr/bin/sh

NVIM=~/.config/nvim
TMP=./.tmp

# check if $NVIM/plugin folder exists
if [ -d $NVIM/plugin ]; then
    mkdir -p $TMP/plugin
    cp -r $NVIM/plugin/* $TMP/plugin
fi

# empty $NVIM folder
rm -rf $NVIM
mkdir -p $NVIM

# copy nvim config to $NVIM folder
cp -r ./nvim/* $NVIM
cp ./stylua.toml $NVIM

# check if $TMP/plugin folder exists
if [ -d $TMP/plugin ]; then
    cp -r $TMP/plugin $NVIM/plugin
fi

rm -rf $TMP
