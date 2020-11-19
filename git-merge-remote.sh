#!/usr/bin/env bash

if [ "$1" ]; then
  cd ../$1
fi

git pull --unshallow
git remote add upstream $2
git fetch upstream
git checkout master
git merge --no-edit upstream/master --allow-unrelated-histories

git add .

if [[ -z $(git diff HEAD --stat) ]]; then
  if [[ -z $(git log origin/master..HEAD) ]]; then
     exit
  fi
fi

git commit -m ":repeat: Sync from $2"
git push origin master

exit
