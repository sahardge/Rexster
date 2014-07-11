#!/bin/bash
CASSANDRA=`/usr/bin/etcdctl --peers 172.17.42.1:4001 get /cassandraSeed/node1`
ES=`/usr/bin/etcdctl --peers 172.17.42.1:4001 get /situ/elasticsearch/host`
IP=`/usr/bin/etcdctl --peers 172.17.42.1:4001 get /rexsterIP`


mv config/rexster.xml config/rexster.xml.orig
cat config/rexster.xml.orig | sed -e "/<base-uri>/s/localhost/""$IP""/" > config/rexster.xml
mv config/rexster.xml config/rexster.xml.orig
cat config/rexster.xml.orig | sed -e "/storage.hostname/s/127.0.0.1/""$CASSANDRA""/" > config/rexster.xml
mv config/rexster.xml config/rexster.xml.orig
cat config/rexster.xml.orig | sed -e"/storage.index.search.hostname/s/127.0.0.1/""$ES""/" > config/rexster.xml

./bin/rexster.sh --start
