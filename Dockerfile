FROM postgres

RUN apt-get update
RUN apt-get -y -q install postgis