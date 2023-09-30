---
layout: post
title: "Moving to GitHub Actions and Jekyll 4.2.0"
date: 2021-02-22
comments: true
categories: [tech]
---

# Why the switch?
This blog uses Jekyll, a static website generator framework, to generate the necessary files which are hosted in [GitHub Pages](https://pages.github.com/). This post explains the reasons that made me switch from Github pages' default building mechanism to Github Actions.

While I was trying to resolve a few dependabot security issues which were about a few gems that I was using, I decided to move this blog to the latest jekyll version which is 4.2.0 at the time of this post.
Github, for security reasons, doesn't allow you to move to any jekyll version and will only allow you to use whitelisted ruby gems/plugins.

I am not upgrading the blog site very often, you can probably tell as I am not blogging quite often either. Hence, I wanted to upgrade to the latest and forget about it for a while. Thankfully, the process of achieving this is documented quite well on [Jekyll's website](https://jekyllrb.com/docs/continuous-integration/github-actions/).

The switch and upgrade was quite straightforward. It also works with the latest/stable Ruby (3.0) which is quite cool as I always had some issues with gem incompatibilities. Github needs a yaml file in a specific directory in order to setup your action. Other than that, a GitHub token is needed to be registered in your repository settings. This gives it permissions for public repositories that you own(specifically to update the gh-pages branch).

It's a great time to be a developer when your CI/CD pipeline for a blog looks as simple as that:

```yml:
name: Build and deploy Jekyll site to GitHub Pages

on:
  push:
    branches:
      - master

jobs:
  github-pages:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: helaili/jekyll-action@2.0.5
        env:
          JEKYLL_PAT: ${{ secrets.JEKYLL_PAT }}
```

