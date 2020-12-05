#!/usr/bin/env bash

# $1 repo name
# $2 subTreeFolder
# $3 repo url
# $4 branch name, such as master, main

if [ "$1" ]; then
  cd ../$1
fi

branchName=main

if [ "$4" ]; then
  branchName=$4
fi

git subtree pull --prefix=$2 $3 $branchName

cd ../yx-env && git-push.sh $1
