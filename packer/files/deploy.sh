#!/bin/bash
apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git /opt/reddit
cd /opt/reddit
bundle install
