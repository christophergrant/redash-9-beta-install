# redash-9-beta
This repository contains code that automates the process of upgrading from Redash v8 to v9 beta with the upgraded ODBC drivers (2.6.15)

# How to use:
0. Clone this repository
1. If you have self-signed certs for SSL, copy all certs into the certs/ directory - note that they must have *crt extension
2. Switch to root user for access to docker -  `sudo su`
3. Run install.sh - **BEWARE: this will overwrite your docker-compose.yml file at /opt/redash completely, back-up as needed** - this will build the images with Redash v9 

# AMI Upgrade
This repository also contains an upgrade script in other/upgrade-ami.sh. This upgrades the AMI to the latest versions of nginx, docker, docker-compose, and a full upgrade for apt.
