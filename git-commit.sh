#!/usr/bin/env bash

git add .

if [[ ! -n $(git diff HEAD --stat) ]]; then
  exit
fi

adds=""
updates=""
deletes=""
unmerged=""

let changes=0
while read status filepath; do
  let changes=1
  filename="${filepath##*/}"
  echo "$status | $filename"

  if [ ${status} == 'A' ]; then
    if [ ! $adds ]; then
      adds="$filename"
    else
      adds+="/$filename"
    fi
  elif [ "${status}" == 'M' ]; then
    if [ ! $updates ]; then
      updates="$filename"
    else
      updates+="/$filename"
    fi
  elif [ "${status}" == 'D' ]; then
    if [ ! $deletes ]; then
      deletes="$filename"
    else
      deletes+="/$filename"
    fi
  elif [ "${status}" == 'U' ]; then
    if [ ! $unmerged ]; then
      unmerged="$filename"
    else
      unmerged+="/$filename"
    fi
  fi
done < <(git diff HEAD --name-status)

if ((changes)); then
  newline=$'\n'
  commitmsg=""
  if [[ $adds != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=$newline
    fi
    commitmsg+="feature($adds): added;"
  fi
  if [[ $updates != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=$newline
    fi
    commitmsg+="chore($updates): updated;"
  fi
  if [[ $deletes != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=$newline
    fi
    commitmsg+="refactor($deletes): deleted;"
  fi
  if [[ $unmerged != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=
    fi
    commitmsg+="fix($unmerged): unmerged;"
  fi

  echo "$commitmsg"

  git commit -m "$commitmsg"
#  git pull --rebase
#  git push
fi

#exec bash
