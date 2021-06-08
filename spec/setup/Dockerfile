FROM ruby:3.0

LABEL maintainer="pedrogglima"

WORKDIR /var/www/app

COPY . /var/www/app/

# cache installed gems on volume gems
ENV BUNDLE_PATH /gems
# set default path for gemfile 
ENV BUNDLE_GEMFILE /var/www/app/spec/setup/Gemfile

RUN bundle install --gemfile=spec/setup/Gemfile
