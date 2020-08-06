#!/bin/bash
set -eux

git clone https://github.com/getredash/redash.git
cd redash/
git checkout release/9.0.x

cd ..
cp -f Dockerfile redash/

