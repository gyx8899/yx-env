#!/usr/bin/env bash

# Input your relative directory when need
echo Current path: $PWD
echo
echo Input your relative directory when need

read cdCMD

if [[ $cdCMD == '' ]]; then
  cdCMD=.
fi
cd $cdCMD
echo Current path: $PWD
echo

# Ask for remote repository url
echo Please input your remote template repository url: Default with enter key

read -s -n 1 repositoryUrl

echo $repositoryUrl

if [[ $repositoryUrl == '' ]]; then
  repositoryUrl="https://github.com/gyx8899/npm-template.git"
  echo Your are using default repositoryUrl: $repositoryUrl
fi

echo $repositoryUrl

git remote add template $repositoryUrl
git fetch --all

echo Do you need auto merge: y: yes, others: no

read -s -n 1 autoMerge

if [[ $autoMerge == 'y' ]]; then
  git merge template/master --allow-unrelated-histories
fi

#exec bash
