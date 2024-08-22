# syntax=docker/dockerfile:1

ARG RUBY_VERSION
ARG DISTRO_NAME=bookworm

FROM ruby:$RUBY_VERSION-slim-$DISTRO_NAME

ARG DISTRO_NAME

# Common dependencies
# Using --mount to speed up build with caching, see https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#run---mount
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache; \
  apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    git \
    less \
    libmagickwand-dev \
    libpq-dev \
    libyaml-dev \
    nodejs \
    postgresql \
    postgresql-contrib

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

ENV BUNDLE_APP_CONFIG=.bundle

RUN git config --system --add safe.directory "*"

RUN gem update --system && \
    gem install bundler

RUN mkdir -p /app
WORKDIR /app

RUN echo $RUBY_VERSION > /app/.ruby-version

EXPOSE 3000

CMD ["/usr/bin/bash"]
