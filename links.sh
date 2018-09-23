#!/bin/bash

folowing=(
    vim
    config/fish/fishfile
    ssh/config
)

for file in ${folowing[*]};do
    [ -e ${HOME}/.${file}.bak ] && rm -r ${HOME}/.${file}.bak
    [ -e ${HOME}/.${file} ] && mv ${HOME}/.${file} ${HOME}/.${file}.bak
    ln -s ${PWD}/${file} ${HOME}/.${file}
done
