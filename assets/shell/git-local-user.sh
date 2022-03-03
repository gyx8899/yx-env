#!/usr/bin/env bash

gitSetConfig(){
  # [ ! -d .git ] 当前目录是 git 目录
  # [ -L file ] 如果 file 存在并且是一个符号链接，则为 true

  # if [ -d "$1" ] && [ ! -L "$1" ] && [ ! -d .git ] ; then
  if [ -d "$1" ] && [ ! -d .git ] ; then
    cd $1
    echo ""
    echo "path: ${PWD}"
    if [ -n "$2" ] ; then
      
      echo "Before update local user.name:" $(git config --local user.email)

      git config --local user.name $2
  #    git config --local --unset user.name

  #    Divider
      echo "After  update local user.name:" $(git config --local user.name)
    fi
    if [ -n "$3" ] ; then
      echo "Before update local user.email:" $(git config --local user.email)

      git config --local user.email $3
  #    git config --local --unset user.email

  #    Divider
      echo "After  update local user.email:" $(git config --local user.email)
    fi
    echo ""
  fi

  cd ..

  return 0
}

echo $1 $2 $3

currentFolder=$(basename $PWD)
# 当前文件的路径 yx-env/assets/shell，需要跳到项目目录
cd ../../../

# [ -n string ]：如果字符串string的长度大于零，则判断为真
if [ -n "$1" ]; then
  echo 'gitSetConfig' $1 $2 $3 
  gitSetConfig $1 $2 $3
else
  for f in *; do
    echo "*: $f"
    if [[ $f != $currentFolder ]]; then
        gitSetConfig $f $2 $3
    fi
  done
fi

# exec bash
