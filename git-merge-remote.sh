#!/usr/bin/env bash

# github-cheat-sheet.md
# https://gist.github.com/spences10/5c492e197e95158809a83650ff97fc3a

if [ "$1" ]; then
  cd ../$1
fi

branchName="master"
if [ "$3" ]; then
  branchName=$3
fi

#git pull --unshallow
git fetch --depth=10000
git remote remove upstream
git remote add upstream $2
git fetch upstream
git checkout $branchName
git merge --no-edit upstream/$branchName --allow-unrelated-histories
git checkout --theirs .
git add .

if [[ -z $(git diff HEAD --stat) ]]; then
  if [[ -z $(git log origin/$branchName..HEAD) ]]; then
     exit
  fi
fi

git commit -m ":repeat: Sync from $2"
git push origin $branchName

exit
