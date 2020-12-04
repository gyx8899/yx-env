#!/usr/bin/env bash

if [ "$1" ]; then
  cd ../$1
fi

git subtree pull --prefix=$2 $3 main

cd ../yx-env && git-push.sh $1
