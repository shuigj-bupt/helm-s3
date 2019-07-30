FROM alpine

MAINTAINER cnych <icnych@gmail.com>

ARG HELM_VERSION="v2.10.0"
ENV HELM_HOME /
RUN apk add --update ca-certificates \
 && apk add --update -t deps wget git openssl bash \
 && wget https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && tar -xvf helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm -f /helm-${HELM_VERSION}-linux-amd64.tar.gz
 
RUN apk -Uuv add groff less python py-pip \
 && pip install awscli \
 && apk --purge -v del py-pip \
 && apk add make \
 && apk add git

RUN helm plugin install https://github.com/hypnoglow/helm-s3.git

ENTRYPOINT ["helm"]
CMD ["help"]
