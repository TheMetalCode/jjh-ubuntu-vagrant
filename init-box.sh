#!/bin/bash

set -e
set -x

# To enable the latest and greatest git to be installed via apt-get
sudo add-apt-repository -yy ppa:git-core/ppa
sudo apt-get update
sudo apt-get -yy upgrade
sudo apt-get -yy install git nano build-essential apt-transport-https ca-certificates python-pip gnupg2 \
    libgmp3-dev libpq-dev xvfb unzip nfs-kernel-server
# Because who doesn't want to check their internet speed via CLI?
sudo pip install speedtest-cli

# Install PhantomJS
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
sudo tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2
sudo mv phantomjs-2.1.1-linux-x86_64 /usr/local/share
sudo ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
echo "phantomjs: $(phantomjs -v)"

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
curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Install heroku toolbelt & docker plugin
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku plugins:install heroku-docker

# Install RVM for ruby dependency mgmt
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.profile
rvm reload
rvm autolibs enable

# Install NVM/Node for node/npm dependency mgmt
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install stable
nvm alias default stable
nvm use default
npm install -g npm@2.15.2

sudo apt-get -yy autoremove

# git completion, pretty prompt, some aliases
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /home/vagrant/.git-completion.bash
cp /vagrant/files/.bash_git_completion /home/vagrant/.bash_git_completion
cp /vagrant/files/.git_shortcuts /home/vagrant/.git_shortcuts
echo 'source /home/vagrant/.bash_git_completion' >> /home/vagrant/.bash_profile
echo 'source /home/vagrant/.git_shortcuts' >> /home/vagrant/.bash_profile
