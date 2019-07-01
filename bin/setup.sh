#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"

ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/tmux.conf ~/.tmux.conf

