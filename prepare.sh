#!/bin/bash
set -eux

# Download the repo
git clone https://github.com/getredash/redash.git

# Copy certs for worker SSL into the Redash Docker context so we can bake them into the server image
mkdir redash/certs
cp -f ../certs/* redash/certs

# Copy modified Dockerfile into the Redash Docker context
cp -f data/Dockerfile redash/
