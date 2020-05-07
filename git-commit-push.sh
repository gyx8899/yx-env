#!/usr/bin/env bash

hasChange=""

if [[ -n $(git diff HEAD --stat) ]]; then
  hasChange="local-diff"
  . ./git-commit.sh
elif [[ $(git status) == *"Your branch is ahead of"* ]]; then
  hasChange="commit-diff"
fi

if [[ $hasChange != '' ]]; then
  git pull --rebase
  git push
fi

#exec bash
