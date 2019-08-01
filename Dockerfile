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

RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
#RUN ["/bin/bash", "-c", "source ~/.bashrc; export LC_ALL=C.UTF-8 >> ~/.bashrc; export LANG=en_US.UTF-8 >> ~/.bashrc; export LANGUAGE=en_US.UTF-8 >> ~/.bashrc"]

RUN apt update \
  && apt install git curl libssl-dev libreadline-dev \
  zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev ruby-full -y \
  && gem install bundler \
  && bundle install 

EXPOSE 4000:4000

#ENTRYPOINT ["/bin/bash"]