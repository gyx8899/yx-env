#!/usr/bin/env bash

echo "Start"

[[ "Enumerating objects: 23, done." =~ Enumerating* ]] && echo "Single line match successful!"

MultipleLineString='
Enumerating objects: 23, done.
Counting objects: 100% (23/23), done.
Delta compression using up to 8 threads
ompressing objects: 100% (11/11), done.
Writing objects: 100% (12/12), 1.18 KiB | 401.00 KiB/s, done.
Total 12 (delta 9), reused 0 (delta 0)
remote:
remote: To create a merge request for [branch], visit:
remote:   url
remote:
To repo url
   48476dde0..d482e18b6  [branch] -> [branch]
'
STRINGTEST=(${MultipleLineString[@]})
echo "${STRINGTEST[0]}"
echo "${STRINGTEST[1]}"
echo "${STRINGTEST[2]}"
echo "${STRINGTEST}"

[[ $MultipleLineString =~ Enumerating* ]] && echo "Multiple line match successful!"

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

echo "stRING" | awk '{print toupper($0)}'
echo "STRING" | tr "[A-Z]" "[a-z]" # upper to lower
echo "StrinNG" | sed 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' #lower to upper

# fileName="heLLo"
# lowerstr=tr '[A-Z]' '[a-z]' < $fileName
# echo $lowerstr

awk '{print tolower($0)}' <<<"DEMO"
var="Foo BAR"
awk '{print tolower($0)}' <<<"${var}"
echo "$var" | awk '{print tolower($0)}'

# To Save in the variable use below
var1=$(echo loWer to Upper | tr '[:lower:]' '[:upper:]')
echo "var1: $var1"
var2=$(echo uPPer to Lower | tr '[:upper:]' '[:lower:]')
echo "var2: $var2"
var3="aBc, Def"
var3=$(echo $var3 | tr '[:upper:]' '[:lower:]')
echo "var3: $var3"

echo "End"

exec bash
