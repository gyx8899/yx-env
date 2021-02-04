#!/usr/bin/env bash

gitSetConfig(){
  # [ ! -d .git ] 当前目录是 git 目录
  if [ -d "$1" ] && [ ! -L "$1" ] && [ ! -d .git ] ; then
    cd $1

    if [ -d "$2" ] && [ ! -L "$2" ] &&[ -d "$3" ] && [ ! -L "$3" ] ; then
      echo ""
      echo "Before update local user.name :" $(git config --local user.name)
      echo "Before update local user.email:" $(git config --local user.email)

      git config --local user.name $2
      git config --local user.email $3

  #    git config --local --unset user.name
  #    git config --local --unset user.email

  #    Divider
      echo ""
      echo "After update local user.name  :" $(git config --local user.name)
      echo "After update local user.email :" $(git config --local user.email)
    fi
  fi

  cd ..

  return 0
}

currentFolder=$(basename $PWD)
cd ..
if [ -n "$1" ]; then
  gitSetConfig $1 $2 $3
else
  for f in *; do
    if [[ $f != $currentFolder ]]; then
        gitSetConfig $f
    fi
  done
fi

#exec bash
