#!/usr/bin/env bash

bundle install

bundle exec rake parallel:migrate[3]
# bundle exec rake db:migrate RAILS_ENV=test

bundle exec rake parallel:spec[3] && \
bundle exec rake parallel:features[2]
