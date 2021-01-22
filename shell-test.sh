#!/usr/bin/env bash

#git status

git pull --rebase
# Current branch master is up to date.
read -r gitPullRebaseInfo

if [ "${gitPullRebaseInfo}" == 'Current branch master is up to date.' ]; then
  git push
  exit
else
  echo "gitPullRebaseInfo = 'gitPullRebaseInfo'!"
  exec bash
fi
