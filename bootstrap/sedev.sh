# /bin/bash

# ;bind_address = 127.0.0.1

sed "s/;bind_address = 127.0.0.1/;bind_address = 127.0.0.1 \n; @note allow remotes for port forwarding. \nbind_address = 0.0.0.0/" < "/etc/couchdb/local.ini" > "/home/vagrant/sed_output"
