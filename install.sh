REDASH_DOCKER_HOME=/opt/redash

git clone https://github.com/getredash/redash.git
cd redash/
git checkout release/9.0.x
sudo su
docker build --pull=true --build-arg databricks_odbc_driver_url="https://databricks.com/wp-content/uploads/2.6.15.1018/SimbaSparkODBC-2.6.15.1018-Debian-64bit.zip" -t redash/redash:9.0.x-new-odbc .

# docker compose yaml edited to use the new odbc image, as well as migrate from v8 to v9 
# https://github.com/getredash/redash/releases/tag/v9.0.0-beta
mv new_docker-compose.yml $REDASH_DOCKER_HOME/docker-compose.yml
docker-compose up --force-recreate --build

exit
