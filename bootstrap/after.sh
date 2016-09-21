#!/usr/bin/env bash
#
# execute this in the guest VM (cd /vagrant).
# DO NOT EXECUTE ON HOST COMPUTER 
# (./bootstrap/after.sh)
# configure stuff after original provision completes.
# 

argument=$1

if [[ $argument == "couchdb_admin" ]]; then
    echo "$argument set"
    # configure couchdb admin
    curl -X 'PUT' "localhost:5984/_config/admins/waka" -d '"wakatime"'
fi

# sudo chown -R vagrant:vagrant /home/vagrant/.nvm

# load university

mkdir -p /home/vagrant/Workspace/projects

cd /home/vagrant/Workspace/projects

git clone https://github.com/hapijs/university.git

cd /home/vagrant/Workspace/projects/university

ls -la

# change server host configs to use: 0.0.0.0

sed "s/\(^.*host:\)\(.*'\)\(.*\)'/\1 '0.0.0.0'/" < "./lib/start.js" > "./lib/devStart.js"

mv "./lib/devStart.js" "./lib/start.js"

# configure git for me

git config --global core.editor vim
git config --global user.name "Jon Swenson"
git config --global user.email "jswenson74@gmail.com"

