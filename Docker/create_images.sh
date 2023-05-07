#!/usr/bin/env bash

docker ps -a | grep salt | awk '{ print $1 }' | xargs docker rm

# Create master image
echo "Creating image: Master"
if [ ! -f master.Dockerfile ]; 
  then
    echo "Dockerfile not exists"
  fi
docker build -t saltmaster -f master.Dockerfile .

# Create minion image: Debian
echo "Creating image: Minion Debian"
if [ ! -f minion.Dockerfile ]
  then
    echo "Dockerfile not exists!"
  fi
docker build -t saltminiondebian -f minion.Dockerfile .

echo "Removin <none> images"
IMG="$(docker images | grep none | awk '{ print $3 }')"
echo "Removing images: $IMG"
docker rmi $IMG

echo "Done"


