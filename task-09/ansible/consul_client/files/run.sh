#!/bin/bash

sudo docker container run --detach \
--name=consul-agent \
--restart=unless-stopped \
--volume /home/ubuntu/consul-client.json:/consul/config/consul-client.json \
--network=host \
hashicorp/consul:latest \
agent
