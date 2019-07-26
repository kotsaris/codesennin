#Rebuild image from scratch after it has stopped
#docker ps -q | %{ docker kill $_ } ; docker container prune -f; docker build --tag myjekyll .
#docker run --rm -it -v ${pwd}:/usr/src/app -p "4000:4000" myjekyll
FROM ubuntu:19.04

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt update \
  && apt install git curl libssl-dev libreadline-dev \
  zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev ruby-full -y \
  && gem install bundler \
  && bundle install \
  /bin/bash -c 'source $HOME/.bashrc; export LC_ALL=C.UTF-8 >> ~/.bashrc \
  && export LANG=en_US.UTF-8 >> ~/.bashrc \
  && export LANGUAGE=en_US.UTF-8 >> ~/.bashrc'

EXPOSE 4000:4000

#CMD bundle exec rake test && jekyll serve -d /_site --watch --force_polling -H 0.0.0.0 -P 4000

#ENTRYPOINT ["/bin/bash"]