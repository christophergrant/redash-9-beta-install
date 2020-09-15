#!/bin/bash
set -eux

git clone https://github.com/christophergrant/redash.git
cd redash/
#git checkout release/9.0.x

cd ..
cp -f data/Dockerfile redash/
