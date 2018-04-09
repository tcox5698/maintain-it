#!/usr/bin/env bash

bundle install

bundle exec rake db:migrate RAILS_ENV=test

bundle exec rspec && \
bundle exec cucumber
