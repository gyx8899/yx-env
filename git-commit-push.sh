#!/usr/bin/env bash

hasChange=""
echo "$1"
if [[ -n $(git diff HEAD --stat) ]]; then
  hasChange="local-diff"
  . ./git-commit.sh $1
elif [[ $(git status) == *"Your branch is ahead of"* ]]; then
  hasChange="commit-diff"
  if [ "$1" ]; then
    cd ../$1
  fi
fi

if [[ $hasChange != '' ]]; then
  git pull --rebase
  git push
fi

#exec bash
