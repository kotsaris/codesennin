FROM ubuntu:20.04
EXPOSE 4000

WORKDIR /usr/src/app

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8

RUN apt update \
  && apt install git curl libssl-dev libreadline-dev \
  zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev ruby-full -y \
  && gem install bundler

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

ENTRYPOINT [ "jekyll", "serve", "-H", "0.0.0.0"]