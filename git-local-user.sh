#!/usr/bin/env bash

gitPullRebase(){
  if [ -d "$1" ] && [ ! -L "$1" ] && [ ! -d .git ] ; then
    cd $1
    echo $1

#    git config user.name
#    git config user.email

#    git config --local user.name
#    git config --local user.email

    git config --local user.name "[user]"
    git config --local user.email "[user]@xxxxx.com"

#    git config --local --unset user.name
#    git config --local --unset user.email

#    Divider
    echo "user.name [user]"
    echo "user.email [user]@xxxxx.com"
    echo ""
  fi

  cd ..

  return 0
}

currentFolder=$(basename $PWD)
cd ..
if [ -n "$1" ]; then
  gitPullRebase $1
else
  for f in *; do
    if [[ $f != $currentFolder ]]; then
        gitPullRebase $f
    fi
  done
fi

#exec bash
