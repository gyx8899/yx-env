#!/usr/bin/env bash

gitPullRebase(){
  if [ -d "$1" ] && [ ! -L "$1" ] && [ ! -d .git ] ; then
    cd $1
    echo $1

    git config --local user.name "Yingxin Guo"
    git config --local user.email "yingxin.guo@neulion.com.cn"

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
