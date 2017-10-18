#!/bin/bash

apt-get install -y rbenv build-essential autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev

git config --global user.name 'Andrey Glauzer'
git config --global user.email nglauzer@gmail.com

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

echo 'eval "$(rbenv init -)"' >> ~/.bashrc

source ~/.bashrc

rbenv install -l

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash




install clang make ruby-dev libffi-dev