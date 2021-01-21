#!/usr/bin/env bash

# github-cheat-sheet.md
# https://gist.github.com/spences10/5c492e197e95158809a83650ff97fc3a

if [ "$1" ]; then
  cd ../$1
fi

#git pull --unshallow
git fetch --depth=10000
git remote remove upstream
git remote add upstream $2
git fetch upstream
git checkout master
git merge --no-edit upstream/master --allow-unrelated-histories
git checkout --theirs .
git add .

if [[ -z $(git diff HEAD --stat) ]]; then
  if [[ -z $(git log origin/master..HEAD) ]]; then
     exit
  fi
fi

git commit -m ":repeat: Sync from $2"
git push origin master

exit
