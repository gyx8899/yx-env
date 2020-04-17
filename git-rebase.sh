#!/usr/bin/env bash

filterNonRepo(){
  for folderName in 'env' '.idea';
  do
    if [ "$folderName" == "$1" ]; then
      isRepo=false
    fi
  done
  return 0
}

isRepo=true

gitPullRebase(){
  isRepo=true
  filterNonRepo $1

  if [ -d "$1" ] && [ ! -L "$1" ] && [ $isRepo = true ] ; then
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

    cd ..

#    Divider
    echo ""
    echo ""
    echo ""
  fi

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