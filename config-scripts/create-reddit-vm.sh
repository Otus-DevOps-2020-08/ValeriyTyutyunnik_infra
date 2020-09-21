#!/bin/bash
yc compute instance create \
  --name reddit-full \
  --hostname reddit-full \
  --memory=4 \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --create-boot-disk image-family=reddit-full,size=10GB \
  --preemptible \
  --ssh-key ~/.ssh/appuser.pub
