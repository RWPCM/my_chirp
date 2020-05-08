FROM bitwalker/alpine-elixir-phoenix:latest

RUN apk update &&\
    apk add postgresql-client &&\ 
    apk add -u yarn

# RUN apk upgrade nodejs
RUN rm -rf /var/cache/apk/*
RUN elixir --version && node --version

RUN export NODE_PATH=/usr/lib/node_modules:$NODE_PATH

EXPOSE 4000
ENV PORT 4000

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

ADD ./scripts/main_script.sh ./main_script.sh
ADD ./scripts/test_db_connection.sh ./test_db_connection.sh


RUN chmod +x main_script.sh test_db_connection.sh

# USER default

CMD tail -f /dev/null