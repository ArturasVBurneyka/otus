#!/bin/bash

sudo docker container run --detach \
--name=consul-server \
--restart=unless-stopped \
--volume /home/ubuntu/consul-server.json:/consul/config/consul-server.json \
--network=host \
hashicorp/consul:latest \
agent -bootstrap-expect=3
