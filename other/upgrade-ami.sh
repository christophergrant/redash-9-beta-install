# system-wide
apt-get update
apt-get upgrade

# docker-compose
rm -rf /usr/local/bin/docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# nginx
docker build -t redash/nginx .

# docker update
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
