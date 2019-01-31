#!/bin/sh -eu

remote_repo="git@github.com:${GITHUB_REPOSITORY}.git"
remote_branch=${BRANCH:-gh-pages}
export HUGO_ENV=production

echo '👍 ENTRYPOINT HAS STARTED—PREPARING SSH'
mkdir /root/.ssh
echo 'github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==' > /root/.ssh/known_hosts
echo "${GIT_DEPLOY_KEY}" > /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa

echo '👍 PREPARED SSH—UPDATING SUBMODULES'
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
