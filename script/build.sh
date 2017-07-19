#!/usr/bin/env bash

bundle install

bundle exec rake db:migrate

bundle exec rspec && \
bundle exec cucumber