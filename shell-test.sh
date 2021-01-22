#!/usr/bin/env bash

#git status

git pull --rebase
# Current branch master is up to date.

if [ "${REPLY}" == 'Current branch master is up to date.' ]; then
  git push
  exit
else
  echo "REPLY = '$REPLY'!"
fi
