#!/bin/bash

cd ansible/playbooks
for f in ./*.yml; do
  echo  -= ansible lint check for $f =-
  ansible-lint $f --exclude=roles/jdauphant.nginx
done
