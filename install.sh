#!/bin/bash

# [[ "${EUID}" -eq 0 ]] || sudo $0 $@

sudo apt update && sudo apt upgrade
sudo apt install -y \
    pt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    fish

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt update && sudo apt install -y docker-ce

curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo groupadd docker
sudo usermod -aG docker ${USER}

# curl -L https://get.oh-my.fish | fish
chsh -s /usr/bin/fish

