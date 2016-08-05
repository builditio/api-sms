FROM ruby:2.3.0

RUN apt-get update -qq && apt-get install -y apt-utils build-essential

# for postgres
RUN apt-get install -y libmysqlclient-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN gem install bundler
RUN bundle install

ADD . $APP_HOME
