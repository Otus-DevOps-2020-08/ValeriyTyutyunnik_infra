#!/bin/bash
set -v

cd ansible/playbooks
for f in ./*.yml; do
  ansible-lint $f --exclude=roles/jdauphant.nginx
done
