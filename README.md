# Codesennin.com

Welcome to the sources of my blog. Feel free to clone this for your own Jekyll blog. 

## Run it locally

The following command builds the site and runs it on http://localhost:4000/

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