#!/usr/bin/env bash

if [ "$1" ]; then
  cd ../$1
fi

git add .

if [[ -z $(git diff HEAD --stat) ]]; then
  if [[ -z $(git log origin/master..HEAD) ]]; then
     exit
  fi
fi
statusX=""

adds=""
updates=""
deletes=""
unmerged=""
renamed=""
copied=""

changes=0
while read -r status filepath; do
  changes=1
  filename="${filepath##*/}"
  statusX=${status:0:1}
  echo "$statusX: $status | $filename"

  if [ "${statusX}" == 'A' ]; then
    if [ ! $adds ]; then
      adds="$filename"
    else
      adds+="/$filename"
    fi
  elif [ "${statusX}" == 'M' ]; then
    if [ ! $updates ]; then
      updates="$filename"
    else
      updates+="/$filename"
    fi
  elif [ "${statusX}" == 'D' ]; then
    if [ ! $deletes ]; then
      deletes="$filename"
    else
      deletes+="/$filename"
    fi
  elif [ "${statusX}" == 'R' ]; then
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
  elif [ "${status}" == 'c' ]; then
    if [ ! $copied ]; then
      copied="$filename"
    else
      copied+="/$filename"
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
      commitmsg+=$newline
    fi
    commitmsg+=":pencil2: refactor($renamed): renamed;"
  fi
  if [[ $unmerged != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=$newline
    fi
    commitmsg+=":bug: fix($unmerged): unmerged;"
  fi
  if [[ $copied != '' ]]; then
    if [[ $commitmsg != '' ]]; then
      commitmsg+=$newline
    fi
    commitmsg+="📋 refactor($copied): copied;"
  fi

  echo "$commitmsg"

  git commit -m "$commitmsg"
fi

git pull --rebase

git push | (
    unset gitPushStatus
    while read -r line; do
      echo "$line"
      case "$line" in
      *Enumerating*)  gitPushStatus='true' ; ;;
      esac
    done
    [ -n "$gitPushStatus" ] && read -rsp "Error: git push" && exit 1
)
