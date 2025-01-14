#!/usr/bin/bash

function create_github_repository()
{
  export user=jinghuazhao
  export token=$(awk "NR==2" ~/doc/access)
  export API=https://api.github.com
  export header="Accept: application/vnd.github.v3+json"
  export name=gaawr2

# 1. create the repository
  curl -X POST -u $user:$token -H "$header" -d '{"name": "'"$name"'"}' $API/user/repos

# 2. list the repository
  curl -H "$header" $API/repos/$user/$name

# 3. delete the repository
# curl -X DELETE -u $user:$token -H "$header" $API/repos/$user/$name

# 4. customise settings and commit
  git config --global user.email "jinghuazhao@hotmail.com"
  git config --global user.name "jinghuazhao@github.com"
  git config --global url."https://jinghuazhao@github.com".insteadOf "https://github.com"
  git init
  git branch -M main
  git remote add origin git@github.com:jinghuazhao/gaawr2.git
  git commit --allow-empty -m "Initial commit"
  git push --set-upstream origin main
}

create_github_repository
