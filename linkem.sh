#!/bin/bash

for f in .*; do
    if [ -f $f ]; then
        if [ -h ~/$f ]; then
            #echo "Replacing old link: ~/$f"
            rm ~/$f
        fi

        if [ ! -e ~/$f ]; then
            echo "Creating: ~/$f"
            ln -s ~/dotfiles/$f ~/$f
        fi
    fi
done
