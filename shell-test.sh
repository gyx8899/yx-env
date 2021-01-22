#!/usr/bin/env bash

#git status

git pull --rebase
# Current branch master is up to date.

while read -r gitPullRebaseInfo; do
  echo "$gitPullRebaseInfo"
  if [ "${gitPullRebaseInfo}" == 'Current branch master is up to date.' ]; then
    git push
    exit
  else
    echo "Something wrong! Please have a check."
    exec bash
  fi
done < <(git pull --rebase)
