#!/bin/bash

if [ ( $TRAVIS_BRANCH == "master" && $TRAVIS_EVENT_TYPE == "push" ) || $TRAVIS_EVENT_TYPE == "pull_request" ]; then
  docker exec hw-test bash -c './play-travis/ansible_check.sh'
  docker exec hw-test bash -c './play-travis/packer_check.sh'
  docker exec hw-test bash -c './play-travis/terraform_check.sh'
else
  echo 'skipping checks';
fi
