#!/bin/bash
docker kill graylog-web-1 && docker rm graylog-web-1
docker kill graylog-server-1 && docker rm graylog-server-1
docker kill graylog-elasticsearch-1 && docker rm graylog-elasticsearch-1
docker kill graylog-mongodb-1 && docker rm graylog-mongodb-1

