#!/usr/bin/env bash

gitSetConfig(){
  # [ ! -d .git ] 当前目录是 git 目录

  if [ -d "$1" ] && [ ! -L "$1" ] && [ ! -d .git ] ; then
    cd $1
    if [ -n "$2" ] ; then
      echo "Before update local user.email:" $(git config --local user.email)

      git config --local user.name $2
  #    git config --local --unset user.name

  #    Divider
      echo ""
      echo "After update local user.name  :" $(git config --local user.name)
    fi
    if [ -n "$3" ] ; then
      echo "Before update local user.email:" $(git config --local user.email)

      git config --local user.email $3
  #    git config --local --unset user.email

  #    Divider
      echo "After update local user.email :" $(git config --local user.email)
    fi
  fi

  cd ..

  return 0
}

echo $1 $2 $3

currentFolder=$(basename $PWD)
cd ..

# [ -n string ]：如果字符串string的长度大于零，则判断为真
if [ -n "$1" ]; then
  echo 'gitSetConfig' $1 $2 $3
  gitSetConfig $1 $2 $3
else
  for f in *; do
    if [[ $f != $currentFolder ]]; then
        gitSetConfig $f $2 $3
    fi
  done
fi

exec bash
