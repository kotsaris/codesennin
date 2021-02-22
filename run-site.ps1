docker build . -t jekyll
docker run --rm -it -v ${pwd}:/usr/src/app -p 4000:4000 jekyll