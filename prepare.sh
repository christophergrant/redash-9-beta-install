#!/bin/bash
set -eux

git clone https://github.com/getredash/redash.git
cp -f data/Dockerfile redash/
