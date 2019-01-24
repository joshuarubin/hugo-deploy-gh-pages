# Hugo for GitHub Pages

GitHub Action for building and deploying Hugo site to GitHub Pages

Inspired by:

- [BryanSchuetz/jekyll-deploy-gh-pages](https://github.com/BryanSchuetz/jekyll-deploy-gh-pages)
- [khanhicetea/gh-actions-hugo-deploy-gh-pages](https://github.com/khanhicetea/gh-actions-hugo-deploy-gh-pages)

## Environment Variables

- `BRANCH` - choose the branch to deploy to, optional, defaults to `gh-pages`

## Secrets

- `GITHUB_TOKEN` - *required* for pushing files to branch

## Example

```hcl
workflow "Deploy to GitHub Pages" {
  on = "push"
  resolves = ["hugo-deploy-gh-pages"]
}

action "hugo-deploy-gh-pages" {
  uses = "joshuarubin/hugo-deploy-gh-pages@master"
  secrets = ["GITHUB_TOKEN"]
}
```
