#!/usr/bin/env bash

git add .

if [[ ! -n $(git diff HEAD --stat) ]]; then
  exit
fi

adds=""
updates=""

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
  else
    if [ "${status}" == 'M' ]; then
      if [ ! $updates ]; then
        updates="$filename"
      else
        updates+="/$filename"
      fi
    fi
  fi
done < <(git diff HEAD --name-status)

if ((changes)); then
  newline=$'\n'
  commitmsg=""
  if [[ $adds != '' ]]; then
    commitmsg+="feature($adds): added;"
    commitmsg+=$newline
  fi
  if [[ $updates != '' ]]; then
    commitmsg+="chore($updates): updated;"
  fi

  echo "$commitmsg"

  git commit -m "$commitmsg"
  git pull --rebase
  git push
fi

#exec bash
