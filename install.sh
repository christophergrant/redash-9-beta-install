#!/bin/bash
set -eux

REDASH_DOCKER_HOME=/opt/redash

# Download the repo
git clone https://github.com/getredash/redash.git
cd redash/
git reset --hard 8b068dfd0b7e03b467bf5c37177fe9c1cb23dae0 # can be commented out, pinning to this to avoid issues with changes in master

cd ..
# Copy certs for worker SSL into the Redash Docker context so we can bake them into the server image
if ls certs/*.crt 2> /dev/null; then
    echo "Found certs, adding to Docker context"
    mkdir redash/certs
    cp -f certs/* redash/certs
    # Copy modified Dockerfile into the Redash Docker context
    if [ openssl sha1 Dockerfile | cut -d' ' -f 2  != "e4c24590da62e007a961027ed85dbe4ae845c90c"]; then
        echo "Dockerfile has been updated, stopping here. Please contact your Databricks representative and delete the redash/ folder"
        exit 1
    else
        cp -f data/Dockerfile redash/
    fi
else
    echo "No self-signed certs to add"
fi

cd redash
# TODO perhaps keep track of the tags for updating purposes
docker build --pull=true -t redash/redash:9.0.x-new-odbc .

# docker compose yaml edited to use the new odbc image, as well as migrate from v8 to v9
# https://github.com/getredash/redash/releases/tag/v9.0.0-beta
cd ..
cp -f data/new_docker-compose.yml $REDASH_DOCKER_HOME/docker-compose.yml
docker-compose -f $REDASH_DOCKER_HOME/docker-compose.yml up --force-recreate --build -d
