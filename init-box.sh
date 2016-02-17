#!/bin/bash

set -e
set -x

sudo chown -R `whoami` /home/vagrant/dev

sudo apt-get update
sudo apt-get -yy upgrade
sudo apt-get -yy install git nano build-essential apt-transport-https ca-certificates python-pip
sudo pip install speedtest-cli

# Install Docker
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo sh -c "cat >/etc/apt/sources.list.d/docker.list" <<EOF
deb https://apt.dockerproject.org/repo ubuntu-trusty main
EOF
sudo apt-get update
sudo apt-get purge lxc-docker
sudo apt-get -yy install linux-image-extra-$(uname -r) apparmor linux-image-generic-lts-trusty linux-headers-generic-lts-trusty
sudo apt-get -yy install docker-engine
sudo usermod -aG docker vagrant
sudo docker run hello-world

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

sudo apt-get -yy autoremove
