#!/bin/bash

apt update -y

curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

apt install -y \
nodejs \
nginx \
git

npm install -g pm2

systemctl enable nginx

systemctl start nginx

echo "Application Server Ready"