FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /railsapi
WORKDIR /railsapi
ADD Gemfile /railsapi/Gemfile
ADD Gemfile.lock /railsapi/Gemfile.lock
RUN bundle install
ADD . /railsapi
CMD ["rails s"]