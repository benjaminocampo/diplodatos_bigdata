#!/bin/bash

set -x

cd "$(git rev-parse --show-toplevel)"

if [ -d .git ]
then

./bin/gopublic.sh

git ls-files  | xargs -d '\n' git checkout master --
#find . -path './.git' -prune -o -type f -print0  | xargs -0 git checkout master --

git status

echo "OK?([y]/n)"
read resp

if [ -z "$resp" ] || [ "$resp" == "y" ]
then
    git commit -m "Files from private"
else
    echo Aborting commit
fi

./bin/goprivate.sh

else
  echo "You are not in base dir of git repo"
fi
