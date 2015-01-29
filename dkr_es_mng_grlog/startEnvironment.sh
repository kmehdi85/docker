#!/bin/bash

echo "start graylog-elasticsearch"
docker run -d -p 9200:9200 -p 9300:9300 -h="graylog-elasticsearch-1" --name="graylog-elasticsearch-1" graylog-elasticsearch
echo "start graylog-mongodb"
docker run -d -p 27017:27017 -p 28017:28017 -h="graylog-mongodb-1" --name="graylog-mongodb-1" graylog-mongodb
echo "waiting until graylog-mongodb is online"
while ! nc -vz localhost 27017; do sleep 1; done
while ! nc -vz localhost 28017; do sleep 1; done
sleep 5s
echo "start graylog-server"
docker run -d -p 12900:12900 -p 12201:12201/udp --link graylog-mongodb-1:mongo --link graylog-elasticsearch-1:elasticsearch -h="graylog-server-1" --name="graylog-server-1" graylog-server
echo "waiting until graylog-server is online"
curl -XPOST http://admin:yummie@127.0.0.1:12900/system/inputs -d @graylog2-server-inputs.json -H "Content-Type:application/json"
while [ $? -ne 0 ]; do
	sleep 2
    curl -XPOST http://admin:yummie@127.0.0.1:12900/system/inputs -d @graylog2-server-inputs.json -H "Content-Type:application/json"
done
echo "start graylog-web"
docker run -d -p 9000:9000 --link graylog-server-1:graylog -h="graylog-web-1" --name="graylog-web-1" graylog-web
