
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

- #### rethinkdb
    provisions vagrant guest with rethinkdb configured
    to allow host to access the web interface at: localhost:8080.

- #### nvm
    installs latest stable nodejs 4.4.7.
    - npm version 3
    - clones hapijs/university into /home/vagrant/university
    - ufw ports
        * 5984 couchdb
        * 8000 hapijs http port.
        * 8001 hapijs https port.

- #### port forwarding
    * HOST      GUEST
    * 8984  ->  5984
    * 8000  ->  8000
    * 8001  ->  8001
    * 9000  ->  9000
    * 9001  ->  9001
    * 8080  ->  8080

- #### NOTES ABOUT PORTS: 
      - 8000(1) webserver
      - 9000(1) api
      - 8984    couchdb 
      - 8080    rethinkdb


- #### hosts configs
    Note: must use 0.0.0.0 with couchdb, rethinkdb, and hapi server
    for Guest machine to allow connections from other computers.
    In other words, your HOST computer will not be able to access the guest VM
    if 0.0.0.0 is not configured as described below. The guest will refuse connections
    because they are not from localhost. Script will configure below except for the hapi server.
    * localhost /etc/hosts file configured to 0.0.0.0
    * /etc/couchdb/local.ini configured to 0.0.0.0
    * /etc/rethinkdb/instances.d/instance1.conf configured to 0.0.0.0
    * hapi server manifest needs to be configured to: 0.0.0.0.
      script does not configure it.

- #### list process using port 
    lsof -i:8984
