#!/bin/bash
#set -ev
set -v
pwd

#if [ ( $TRAVIS_BRANCH == "master" && $TRAVIS_EVENT_TYPE == "push" ) || $TRAVIS_EVENT_TYPE == "pull_request" ]; then
  for f in play-travis/*_check.sh; do

    docker exec hw-test bash -c 'sh pwd'
    docker exec hw-test bash -c 'sh tree'
    docker exec hw-test bash -c 'sh play-travis/$f'
  done
#else
#  echo 'skipping checks';
#fi
