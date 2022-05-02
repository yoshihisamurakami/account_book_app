FROM ruby:2.6.9-alpine
RUN apk update && \
    apk upgrade && \
    apk add --no-cache linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql && \
    apk add --virtual build-packages --no-cache build-base curl-dev
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp
RUN touch /myapp/Gemfile.lock
RUN bundle install
RUN apk del build-packages
COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

