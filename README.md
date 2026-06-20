# Codesennin.com

Welcome to the sources of my blog. Feel free to clone this for your own Jekyll blog.

## Run it locally

This repo pins Ruby 3.3.6. If you use [mise](https://mise.jdx.dev/), the toolchain is configured in `mise.toml`:

```shell
mise install
bundle install
bundle exec rake serve
```

The site will run on http://localhost:4000/.

To build and test the site locally:

```shell
bundle exec rake build
HTMLPROOFER_IGNORE_EXTERNAL=true bundle exec rake test
```

`HTMLPROOFER_IGNORE_EXTERNAL=true` keeps the local test focused on the generated site and internal links, avoiding false failures from remote sites that block automated link checks.

On Windows, the following command builds the Docker image and runs the site on http://localhost:4000/:

```shell
run-site.ps1
```

Alternatively, via WSL2 in Windows fire up Ubuntu and run the following commands when in the blog dir
```
\curl -sSL https://get.rvm.io | bash -s stable --ruby
gem install bundler
bundle install
jekyll serve
```
