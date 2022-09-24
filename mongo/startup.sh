#!/bin/bash
process_name=(dockerd)

# start supervisor
/usr/bin/supervisord -n >> /dev/null 2>&1 &

while ! pgrep "$process_name" > /dev/null 2>&1 ; do
    sleep 1
done

# start mongod 
mkdir -p /data/db
# fork mongod silently (user should not see mongod output)
mongod --fork --logpath /var/log/mongodb/mongod.log --dbpath /data/db >> /dev/null 2>&1 &

/bin/bash