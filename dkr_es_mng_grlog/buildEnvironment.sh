#!/bin/bash

echo "building graylog-server image" \
&& docker build -q -t=graylog-server graylog/server \
&& echo "building graylog-web image" \
&& docker build -q -t=graylog-web graylog/web \
&& echo "building graylog-mongodb image" \
&& docker build -q -t=graylog-mongodb graylog/mongodb \
&& echo "building graylog-elasticsearch image" \
&& docker build -q -t=graylog-elasticsearch graylog/elasticsearch
