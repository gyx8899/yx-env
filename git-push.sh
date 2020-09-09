#!/usr/bin/env bash

if [ "$1" ]; then
  cd ../$1
fi

git add .

if [[ -z $(git diff HEAD --stat) ]]; then
  exit
fi

adds=""
updates=""
deletes=""
unmerged=""
renamed=""

changes=0
while read -r status filepath; do
  changes=1
  filename="${filepath##*/}"
  echo "$status | $filename"

  if [ "${status}" == 'A' ]; then
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
  elif [ "${status}" == 'R095' ]; then
    if [ ! $renamed ]; then
      renamed="$filename"
    else
      renamed+="/$filename"
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
    commitmsg+=":new: feature($adds): added;"
  fi
  if [[ $updates != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=$newline
    fi
    commitmsg+=":art: chore($updates): updated;"
  fi
  if [[ $deletes != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=$newline
    fi
    commitmsg+=":fire: refactor($deletes): deleted;"
  fi
  if [[ $renamed != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=
    fi
    commitmsg+=":pencil2: refactor($renamed): renamed;"
  fi
  if [[ $unmerged != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=
    fi
    commitmsg+=":bug: fix($unmerged): unmerged;"
  fi

  echo "$commitmsg"

  git commit -m "$commitmsg"
  git pull --rebase
  git push
fi

exit
