ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}
LABEL maintainer="Ryan <rashley@iqt.org>"
ENV PYTHONUNBUFFERED 1

ARG PYTHON_VERSION=3.12

RUN apt-get update && apt-get install -y libjpeg-dev build-essential zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev

ENV PATH="${PATH}:/root/.local/bin"
RUN apt-get update && \
  apt-get install -y --no-install-recommends curl gcc git g++ libev-dev libyaml-dev tini ca-certificates
ENV PYENV_ROOT="/pyenv"
RUN curl https://pyenv.run | bash 
ENV PATH="${PATH}:${PYENV_ROOT}/bin:${PYENV_ROOT}/shims"
RUN pyenv install ${PYTHON_VERSION} && \
  pyenv global ${PYTHON_VERSION} && \
  curl -sSL https://install.python-poetry.org | python3 - --version 1.7.1 && \
  poetry config virtualenvs.create false && \
  python3 -m pip install --no-cache-dir --upgrade pip && \
  apt -y autoremove --purge && rm -rf /var/cache/* /root/.cache/*
