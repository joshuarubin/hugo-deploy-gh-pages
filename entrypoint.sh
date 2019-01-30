#!/bin/sh -eu

remote_repo="https://${PAGES_PUSH_USERNAME}:${PAGES_PUSH_ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
remote_branch=${BRANCH:-gh-pages}
export HUGO_ENV=production

echo '👍 ENTRYPOINT HAS STARTED—UPDATING SUBMODULES'
git submodule init
git submodule update --recursive --remote

echo '👍 UPDATED SUBMODULES—PREPARING THE REPO'

(
  mkdir public
  cd public
  git init
  git remote add origin "${remote_repo}"
  git config user.name "${GITHUB_ACTOR}"
  git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
  git pull origin "${remote_branch}"
  git rm -rf .
)

echo '👍 PREPARED THE REPO—BUILDING THE SITE'
hugo -v --minify

echo '👍 THE SITE IS BUILT—PUSHING IT BACK TO GITHUB-PAGES'
(
  cd public
  git add .
  git commit -m "Automated deployment to GitHub Pages at $(date +%s%3N)" --allow-empty
  git push origin "master:${remote_branch}"
)

echo '👍 GREAT SUCCESS!'
