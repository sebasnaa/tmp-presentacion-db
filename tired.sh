#!/bin/bash

# random message from web
message=$(curl -L -s http://whatthecommit.com/ |grep -A 1 "\"c" |tail -1 |sed 's/<p>//')

git add ./
git commit -m "$message"

if [ $# -eq 0 ]
  then
    git push origin master
else
    git push origin $1
fi