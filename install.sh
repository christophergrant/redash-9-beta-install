#!/bin/bash
set -eux

REDASH_DOCKER_HOME=/opt/redash
cd redash/
docker build --pull=true --build-arg databricks_odbc_driver_url="https://databricks.com/wp-content/uploads/2.6.15.1018/SimbaSparkODBC-2.6.15.1018-Debian-64bit.zip" -t redash/redash:9.0.x-new-odbc .

# docker compose yaml edited to use the new odbc image, as well as migrate from v8 to v9
# https://github.com/getredash/redash/releases/tag/v9.0.0-beta
cp -f ../data/new_docker-compose.yml $REDASH_DOCKER_HOME/docker-compose.yml
docker-compose -f $REDASH_DOCKER_HOME/docker-compose.yml up --force-recreate --build -d
