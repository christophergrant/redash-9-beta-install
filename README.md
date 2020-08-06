# redash-9-beta-install
This repository contains code that automates the process of upgrading from v8 to v9 with the upgraded ODBC drivers (2.6.15)

# How to use:
0. Clone this repository
1. Run prepare.sh
2. If you have self-signed certs, copy all self-signed certs into the redash/ directory (must be in the same directory as the Dockerfile). If you do not have self-signed certs, delete lines 81-86 and skip to step 5
3. Switch to root user for access to docker -  `sudo su`
4. Edit the Dockerfile in redash/, particularly lines 84-86 contain <CERT 1 NAME>, change those with the name of your actual cert (If you have multiple certs to add, add a COPY statement and chmod for it)
5. Run install.sh - **BEWARE: this will overwrite your docker-compose.yml file at /opt/redash completely, back-up as needed** - this will build the images with Redash v9 
