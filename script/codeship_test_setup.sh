#!/usr/bin/env bash

ln -s $(which node) ~/bin/nodejs
# We support all major Ruby versions. Please see our documentation for a full list.
# https://documentation.codeship.com/basic/languages-frameworks/ruby/
# If `.ruby-version` file is present, RVM will set Ruby to the declared version.
if [ -f .ruby-version ]; then rvm use $(cat .ruby-version) --install; fi
# If you are not using a `.ruby-version` in your project,
# then the desired version of Ruby can be declared in the following manner:
rvm use 2.6.3 --install
gem install bundler
bundle install
# Make sure Ruby on Rails knows we are in the the test environment.
export RAILS_ENV=test
# Prepare the test database
bundle exec rake db:schema:load
#bundle exec rake db:migrate
#bundle exec rake db:test:prepare
