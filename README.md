
# hapijs university vagrant

### provisions
- #### vim 
    with pathogen and webdev plugins
    * my basic vimrc
    * vim-jsx
    * vim-stylus
    * vim-jsbeautify
    * vim-javascript

- #### git
    configured for my user (bootstrap/after.sh).

- #### couchdb
    admin user loaded.
    bootstrap/after.sh provides the admin user.
- #### nvm
    installs latest stable nodejs 4.4.6.
    - npm version 3
    - clones hapijs/university into /home/vagrant/university
    - ufw ports
        * 5984 couchdb
        * 8000 hapijs http port.
        * 8001 hapijs https port.

- #### port forwarding
    HOST      GUEST
    8984  ->  5984
    8080  ->  8000
    8081  ->  8001

- ####hosts configs
    Note: must use 0.0.0.0 with couchdb and hapi server
    for Guest machine to allow connections from other computers.
    * localhost /etc/hosts file configured to 0.0.0.0
    * /etc/couchdb/local.ini configured to 0.0.0.0
    * hapi server manifest needs to be configured to: 0.0.0.0.
      script does not configure it.

