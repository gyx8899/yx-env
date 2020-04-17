#!/usr/bin/env bash

gitPullRebase(){
  if [ -d "$1" ] && [ ! -L "$1" ] && [ ! -d .git ] ; then
    cd $1
    echo $1
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
    echo ""
  fi

  cd ..

  return 0
}

cd ..
if [ -n "$1" ]; then
  gitPullRebase $1
else
  for f in *; do
    gitPullRebase $f
  done
fi

#exec bash
