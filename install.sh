#!/bin/bash

[[ "${EUID}" -eq 0 ]] || exec sudo $0 $@

apt update && apt upgrade
apt install -y \
    pt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    fish

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt update && apt install -y docker-ce

curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

groupadd docker
usermod -aG docker ${USER}

# curl -L https://get.oh-my.fish | fish
chsh -s /usr/bin/fish

