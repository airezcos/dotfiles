#!/bin/bash

folowing=(
    vim
    config/fish/fishfile
    config/fish/config.fish
    ssh/config
)

for file in ${folowing[*]};do
    printf "\nProsessing ${file}....\n"
    [ -e ${HOME}/.${file}.bak ] && \
        rm -r ${HOME}/.${file}.bak && \
        echo "  --removing old ${HOME}/.${file}.bak"
    [ -e ${HOME}/.${file} ] && \
        mv ${HOME}/.${file} ${HOME}/.${file}.bak && \
        echo "  --moving ${HOME}/.${file} to ${HOME}/.${file}.bak"
    ln -s ${PWD}/${file} ${HOME}/.${file} && \
        echo "  --linking ${PWD}/${file} with ${HOME}/.${file}"
done
printf "\n\n"
