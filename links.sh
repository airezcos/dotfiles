#!/bin/bash

folowing=(
    vim/
    config/fish/fishfile
)

for file in ${folowing[*]};do
    [ -f ${HOME}/.${file}.bak ] && rm -r ${HOME}/.${file}.bak  
    [ -f ${HOME}/.${file} ] && mv ${HOME}/.${file}.bak
    ln -s ${PWD}/${file} ${HOME}/.${file}
done
