FROM alpine:3

MAINTAINER Ahmed cheibani

# Note: Latest version of kubectl may be found at:
# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBE_LATEST_VERSION="v1.18.5"
# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v3.2.4"
ENV FILENAME="helm-${HELM_VERSION}-linux-amd64.tar.gz"

RUN apk add --update --no-cache curl ca-certificates \
# && apk add bash \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl  \
    && curl -L https://get.helm.sh/${FILENAME} |tar xvz \
    && mv linux-amd64/helm /usr/bin/helm  \
    && chmod +x /usr/bin/helm  \
    && rm -rf linux-amd64 \
    && apk --purge del curl  \
    && rm -f /var/cache/apk/* \
    && rm -rf /tmp/*

    # && curl -sSL http://deis.io/deis-cli/install-v2.sh | bash \
    # && mv $PWD/deis /usr/local/bin/deis \
    
WORKDIR /apps
ENTRYPOINT ["helm"]
CMD ["--help"]
