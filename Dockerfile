FROM alpine:3.8

LABEL "com.github.actions.name"="Hugo for GitHub Pages"
LABEL "com.github.actions.description"="Builds and deploys the project to GitHub Pages"
LABEL "com.github.actions.icon"="globe"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/joshuarubin/hugo-deploy-gh-pages"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Joshua Rubin <joshua@rubixconsulting.com>"

LABEL "Name"="Hugo for GitHub Pages"
LABEL "Version"="0.0.1"

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV HUGO_VERSION 0.53

RUN wget -O /tmp/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz &&\
    tar -zxf /tmp/hugo.tar.gz -C /tmp &&\
    mv /tmp/hugo /usr/local/bin/hugo &&\
    rm /tmp/* &&\
    apk add --no-cache \
        git=2.18.1-r0 \
        libc6-compat=1.1.19-r10 \
        libstdc++=6.4.0-r9

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
