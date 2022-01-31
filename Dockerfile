FROM ruby:3.0.0-alpine

ENV BUNDLER_VERSION=2.2.31

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      tzdata \
      openssl \
      postgresql-dev

RUN gem install bundler -v 2.2.31

WORKDIR /pgdc-api

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

COPY . ./

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
