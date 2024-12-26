FROM ruby:3.3.6

WORKDIR /usr/src/app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

# Jekyll runs on port 4000 by default
EXPOSE 4000
# LiveReload runs on port 35729 by default
EXPOSE 35729

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "true", "--force_polling"]
