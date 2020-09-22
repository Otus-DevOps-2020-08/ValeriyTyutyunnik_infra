#!/bin/bash
apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git ~/reddit
cd ~/reddit
bundle install
puma -d
