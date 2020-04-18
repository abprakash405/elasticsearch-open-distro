#FROM alpine:3.7 as builder

#RUN apk add --no-cache zip

FROM docker.elastic.co/elasticsearch/elasticsearch:7.6.1
MAINTAINER cgiraldo@gradiant.org

RUN echo 'ES_JAVA_OPTS="-Des.insecure.allow.root=true"' >> bin/elasticsearch

USER elasticsearch

COPY elasticsearch.yml config/elasticsearch.yml

RUN ls -ltr config

COPY esnode-key.pem config/esnode-key.pem
COPY esnode.pem config/esnode.pem
COPY kirk-key.pem config/kirk-key.pem
COPY kirk.pem config/kirk.pem
COPY root-ca.pem config/root-ca.pem

RUN bin/elasticsearch-plugin install  --batch https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-security/opendistro_security-1.6.0.0.zip

RUN ls -ltr config

#:RUN bin/elasticsearch
