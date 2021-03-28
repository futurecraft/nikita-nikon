FROM ruby:2.7

RUN mkdir -p /app
RUN mkdir -p /app/results/reports

COPY . /app
WORKDIR /app

RUN gem install bundler
RUN bundle install
RUN bundle update