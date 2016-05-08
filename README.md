# Codesennin.com

This is my blog. Shamelessly cloned from github.com\haacked\haacked.com

## Run it locally

The following command builds the site and runs it on http://localhost:4000/

```shell
jekyll serve
```

## Testing

[HTML::Proofer](https://github.com/gjtorikian/html-proofer) is set up to validate all links within the project.  You can run this locally to ensure that your changes are valid:

```shell
bundle install
bundle exec rake test
```