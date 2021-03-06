#!/bin/bash
set -eux

REDASH_DOCKER_HOME=/opt/redash

# Download the repo
git clone https://github.com/getredash/redash.git
cd redash/
git reset --hard 829247c2d2c1a5ac35cee4c356cce8d718727d06 # can be commented out, pinning to this to avoid issues with changes in master

cd ..
# Copy certs for worker SSL into the Redash Docker context so we can bake them into the server image
if ls certs/*.crt 2> /dev/null; then
    echo "Found certs, adding to Docker context"
    mkdir redash/certs
    cp -f certs/* redash/certs
    # Copy modified Dockerfile into the Redash Docker context
    cp -f data/Dockerfile redash/
else
    echo "No certs to add to the image"
fi

cd redash
# TODO perhaps keep track of the tags for updating purposes
docker build --pull=true -t redash/redash:9.0.x-new-odbc .

# docker compose yaml edited to use the new odbc image, as well as migrate from v8 to v9
# https://github.com/getredash/redash/releases/tag/v9.0.0-beta
cd ..
docker-compose -f $REDASH_DOCKER_HOME/docker-compose.yml up --force-recreate --build -d
