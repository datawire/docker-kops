FROM alpine:3.7
MAINTAINER Datawire <dev@datawire.io>
LABEL PROJECT_REPO_URL         = "git@github.com:datawire/docker-kops.git" \
      PROJECT_REPO_BROWSER_URL = "https://github.com/datawire/docker-kops" \
      DESCRIPTION              = "Kops in Docker" \
      VENDOR                   = "Datawire, Inc." \
      VENDOR_URL               = "https://datawire.io/"

ENV GOSU_VERSION=1.10
ENV KOPS_VERSION=1.8.1
ENV KUBECTL_VERSION=v1.8.10

RUN apk --no-cache add ca-certificates \
  && apk --no-cache add --virtual build-dependencies curl \
  && curl -O --location --silent --show-error https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
  && mv gosu-amd64 /usr/local/bin/gosu \
  && curl -O --location --silent --show-error https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 \
  && mv kops-linux-amd64 /usr/local/bin/kops \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
  && mv kubectl /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kops /usr/local/bin/kubectl /usr/local/bin/gosu \
  && apk del --purge build-dependencies

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
