#!/bin/sh -eu

echo '👍 ENTRYPOINT HAS STARTED—UPDATING SUBMODULES'
git submodule init
git submodule update --recursive --remote

echo '👍 UPDATED SUBMODULES—BUILDING THE SITE'

HUGO_ENV=production hugo -v

echo '👍 THE SITE IS BUILT—PUSHING IT BACK TO GITHUB-PAGES'
cd public
remote_repo="https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
remote_branch=${BRANCH:-gh-pages}
git init
git remote add origin "${remote_repo}"
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .
git commit -m "Automated deployment to GitHub Pages at $(date +%s%3N)"
git fetch origin
git merge -s ours --allow-unrelated-histories -m "Merge remote-tracking branch 'origin/${remote_branch}'" "origin/${remote_branch}" || true
git push origin "master:$remote_branch"

echo '👍 GREAT SUCCESS!'
