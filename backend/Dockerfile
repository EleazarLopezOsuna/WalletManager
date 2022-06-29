FROM ruby:2.7.2-alpine
RUN apk update
RUN apk add nodejs yarn

RUN apk update && apk add --update --no-cache --virtual build-dependency build-base ruby-dev mysql-dev postgresql-dev git sqlite-dev imagemagick-dev curl openssh openssl tzdata make bash

RUN gem install bundler:2.1.4
RUN apk add --no-cache build-base

RUN gem install mysql2
RUN gem install ffi
RUN gem install nokogiri

RUN mkdir /usr/src/demo
WORKDIR /usr/src/demo
ADD Gemfile /usr/src/demo/Gemfile
ADD Gemfile.lock /usr/src/demo/Gemfile.lock
RUN bundle install
ADD . /usr/src/demo

ENV RAILS_ENV='production'
ENV RACK_ENV='production'
ENV PORT 3000
# ENTRYPOINT ./entrypoint.sh
ENV SECRET_KEY_BASE=f9e612c0c13733da9cd8d3b5a90e4410b039526ae8f407734070aa99e15c9cd3d87380622c502f85883468ff18ee1ed72f6482b70022b220e08d8572b0e68c0e
RUN RAILS_ENV=production bin/rails assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]