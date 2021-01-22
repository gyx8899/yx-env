#!/usr/bin/env bash

echo "Start"

git pull --rebase | (
    echo "00"
    while read -r line; do
      echo "1 - $line"
    done
    echo "22"
)

git status | (
    unset dirty deleted untracked newfile ahead renamed
    while read line ; do
        case "$line" in
          *modified:*)                      dirty='!' ; ;;
          *deleted:*)                       deleted='x' ; ;;
          *'Untracked files:')              untracked='?' ; ;;
          *'new file:'*)                    newfile='+' ; ;;
          *'Your branch is ahead of '*)     ahead='*' ; ;;
          *renamed:*)                       renamed='>' ; ;;
        esac
    done
    bits="$dirty$deleted$untracked$newfile$ahead$renamed"
    [ -n "$bits" ] && echo " $bits" || echo
)

echo "End"

exec bash
