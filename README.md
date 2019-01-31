# Hugo for GitHub Pages

GitHub Action for building and deploying Hugo site to GitHub Pages

Inspired by:

- [BryanSchuetz/jekyll-deploy-gh-pages](https://github.com/BryanSchuetz/jekyll-deploy-gh-pages)
- [khanhicetea/gh-actions-hugo-deploy-gh-pages](https://github.com/khanhicetea/gh-actions-hugo-deploy-gh-pages)

## Create Deploy Key

1. Generate deploy key `ssh-keygen -t ed25519 -f hugo -q -N ""`
1. Then go to "Settings > Deploy Keys" in your repository
1. Copy the hugo public key and check “Allow write access”
1. Copy the hugo private key to the `GIT_DEPLOY_KEY` secret in "Settings > Secrets"

## Environment Variables

- `BRANCH` - choose the branch to deploy to, optional, defaults to `gh-pages`

## Secrets

- `GIT_DEPLOY_KEY` - *required* your deploy key which has **write access**

## Example

```hcl
workflow "Deploy to GitHub Pages" {
  on = "push"
  resolves = ["hugo-deploy-gh-pages"]
}

action "hugo-deploy-gh-pages" {
  uses = "joshuarubin/hugo-deploy-gh-pages@master"
  secrets = [
    "GIT_DEPLOY_KEY",
  ]
  env = {
    BRANCH = "gh-pages"
  }
}
```
