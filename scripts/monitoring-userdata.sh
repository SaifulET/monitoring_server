#!/bin/bash

apt update -y

apt install -y \
docker.io \
docker-compose \
git

systemctl enable docker

systemctl start docker

echo "Monitoring Server Ready"