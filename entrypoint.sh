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
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .
printf "Files to Commit: %d\n" "$(find . -type f | wc -l)"
git commit -m "Automated deployment to GitHub Pages on $(date +%s%3N)"
git push --force "$remote_repo" "master:$remote_branch"

echo '👍 GREAT SUCCESS!'
