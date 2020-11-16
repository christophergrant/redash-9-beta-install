#!/bin/bash
set -eux

REDASH_DOCKER_HOME=/opt/redash

# Download the repo
git clone https://github.com/getredash/redash.git

# Copy certs for worker SSL into the Redash Docker context so we can bake them into the server image
if ls certs/*.crt 2> /dev/null; then
    echo "Found certs, adding to Docker context"
    mkdir redash/certs
    cp -f certs/* redash/certs
    # Copy modified Dockerfile into the Redash Docker context
    cp -f data/Dockerfile redash/
else
    echo "No self-signed certs to add"
    cp -f data/Dockerfile_nocerts redash/Dockerfile
fi

cd redash/
docker build --pull=true --build-arg databricks_odbc_driver_url="https://databricks.com/wp-content/uploads/2.6.15.1018/SimbaSparkODBC-2.6.15.1018-Debian-64bit.zip" -t redash/redash:9.0.x-new-odbc .

# docker compose yaml edited to use the new odbc image, as well as migrate from v8 to v9
# https://github.com/getredash/redash/releases/tag/v9.0.0-beta
cd ..
cp -f data/new_docker-compose.yml $REDASH_DOCKER_HOME/docker-compose.yml
docker-compose -f $REDASH_DOCKER_HOME/docker-compose.yml up --force-recreate --build -d
