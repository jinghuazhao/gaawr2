#!/usr/bin/bash

for f in $(ls)
do
  echo adding ${f}
  git add ${f}
  git commit -m "${f}"
done
git push --set-upstream origin main
du -h --exclude .git
