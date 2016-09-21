#!/usr/bin/env bash
# useful commands
# vagrant up
# vagrant destroy 
# vagrant reload --provision 

apt-get update
apt-get dist-upgrade
apt-get install tree
sudo apt-get -y install git 

# configure vim

mkdir /home/vagrant/.vim-bkup
mkdir /home/vagrant/.vim-tmp

sudo chown vagrant:vagrant .vim-*

mkdir /home/vagrant/.vim
mkdir -p /home/vagrant/.vim/autoload /home/vagrant/.vim/bundle
curl -LSso /home/vagrant/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd /home/vagrant
git clone https://github.com/zoe-1/vimrc-basic.git  
cd -
cp vimrc-basic/basic_vimrc_template /home/vagrant/.vimrc
rm -r vimrc-basic

mkdir -p /home/vagrant/.vim/bundle/vim-jsx
git clone https://github.com/mxw/vim-jsx.git /home/vagrant/.vim/bundle/vim-jsx

mkdir -p /home/vagrant/.vim/bundle/vim-stylus
git clone git://github.com/wavded/vim-stylus.git /home/vagrant/.vim/bundle/vim-stylus

mkdir -p /home/vagrant/.vim/bundle/vim-jsbeautify
git clone https://github.com/maksimr/vim-jsbeautify.git /home/vagrant/.vim/bundle/vim-jsbeautify

mkdir -p /home/vagrant/.vim/bundle/vim-javascript
git clone https://github.com/pangloss/vim-javascript.git /home/vagrant/.vim/bundle/vim-javascript

# install nvm

mkdir /home/vagrant/.nvm
sudo chown vagrant:vagrant /home/vagrant/.nvm

echo "---------"
echo $HOME

#
# install nvm
#
# notes: configure HOME variable for nvm to install
# in proper directory. Otherwise, tries to install at /root.
#

HOME="/home/vagrant"
echo $HOME
curl -o- /home/vagrant/.nvm  https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
HOME="/root"

# verify nvm install
command -v nvm

. /home/vagrant/.nvm/nvm.sh

nvm install v4.5.0

nvm use 4.5.0
nvm alias default 4.5.0
echo $HOME

#
# configure firewall
#

sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 5984
sudo ufw allow 8000
sudo ufw allow 8001
sudo ufw allow 9000
sudo ufw allow 9001
sudo ufw allow 8080

sudo cp /vagrant/bootstrap/hostsFile /etc/hosts

#
# intall couchdb 
# For details see: https://launchpad.net/~couchdb/+archive/ubuntu/stable
#

apt-get install -y software-properties-common

add-apt-repository -y ppa:couchdb/stable

apt-get update -y

apt-get remove couchdb couchdb-bin couchdb-common -yf

apt-get install -Vy couchdb

#
# configure hosts to allow port forwarding.
# # sudo echo "bind_address = 0.0.0.0" >> /etc/couchdb/local.ini

sudo chown vagrant:vagrant /etc/couchdb/local.ini
sudo chown vagrant:vagrant /etc/couchdb/

sed "s/;bind_address = 127.0.0.1/;bind_address = 127.0.0.1 \n; @note allow remotes for port forwarding. \nbind_address = 0.0.0.0/" < "/etc/couchdb/local.ini" > "/home/vagrant/sed_output"

mv "/home/vagrant/sed_output" "/etc/couchdb/local.ini"

sudo restart couchdb

# install npm 3

sudo chown -R vagrant:vagrant /home/vagrant/.nvm
npm install npm@3.10.8 -g

#
# install rethinkdb
#

source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list

wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -

sudo apt-get update -y

sudo apt-get install -y rethinkdb

sudo /etc/init.d/rethinkdb restart

sudo cp /vagrant/bootstrap/rethinkdbInstance.conf /etc/rethinkdb/instances.d/instance1.conf

sudo chown rethinkdb:rethinkdb /etc/rethinkdb/instances.d/instance1.conf

# configured to allow access from all hosts 0.0.0.0.
# Must do to allow host computer to have access.
# web interface accessed at: localhost:8080 port forwarding configured for host too.
# host    guest
# 8080 -> 8080
sudo chmod 0755 /etc/rethinkdb/instances.d/instance1.conf

sudo apt-get update -y

# install pip for python to install drivers.
sudo apt-get install python-pip

# install rethinkdb python driver required by
# rethinkdb to make backups using dump command.
sudo pip install rethinkdb

# restart with new credentials

sudo /etc/init.d/rethinkdb restart

