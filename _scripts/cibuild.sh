#!/bin/bash

# skip if build is triggered by pull request
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# cleanup "_site"
rm -rf _site
mkdir _site

# clone remote repo to "_site"
git clone https://${GH_TOKEN}@github.com/andreyglauzer/andreyglauzer.github.io.git --branch master _site

# build with Jekyll into "_site"
pwd
echo " ========================== "
ls
echo "fazendo o bundle exec jekyll build"
bundle exec jekyll build
echo "Passou"
# push
cd _site
git config --global user.email "nglauzer@gmail.com"
git config --global user.name "Andrey Glauzer"
git add -A
git commit -m "Travis #$TRAVIS_BUILD_NUMBER"
git push origin master --force
