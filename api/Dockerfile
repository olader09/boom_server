FROM ruby:2.6.6-alpine3.12
RUN apk --update add --virtual build-deps build-base && \
    apk add --no-cache su-exec postgresql-dev tzdata git \
        libxml2-dev libxslt-dev less nodejs yarn

RUN adduser -D -u 1000 dev

RUN mkdir /api /bundle

WORKDIR /api
RUN gem install rails -v '6.1.0.rc1'
COPY . /api
RUN bundle install

RUN chown -R dev:dev /api /bundle
USER dev

CMD rails s -p 3555 -b 0.0.0.0
