#!/usr/bin/env bash

gitPullRebase(){
  # 1. 项目目录存在，2.非符号链接目录, 3.有 git 目录
  if [ -d "$1" ] && [ ! -L "$1" ] && [ -d "$1/.git" ] ; then
    cd $2
    echo "$2"
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
  gitPullRebase "$PWD/$1" $1
else
  for f in *; do
    gitPullRebase "$PWD/$f" $f
  done
fi

#exec bash
