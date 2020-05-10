#!/usr/bin/env bash

gitPullRebase(){
  # 1. 项目目录存在，2.非符号链接目录, 3.有 git 目录
  if [ -d "$2/$1" ] && [ ! -L "$2/$1" ] && [ -d "$2/$1/.git" ] ; then
    cd $1
    echo "$1"
    echo ""
    hasDiff=false
    if [[ -n $(git diff HEAD --stat) ]]; then
      hasDiff=true
      git stash
    fi
    git pull --rebase

    if [ "$hasDiff" = true ] ; then
      echo "$f has diff"
      git stash pop
    fi

#    Divider
    echo ""
    echo ""
  fi

  cd ..

  return 0
}

cd ..
if [ -n "$1" ]; then
  gitPullRebase $1 $PWD
else
  for f in *; do
    gitPullRebase $f $PWD
  done
fi

#exec bash
