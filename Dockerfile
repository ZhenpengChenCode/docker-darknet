# Sha256 corresponds to tag 'nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04'
FROM sha256:6cd48444de35a2aa8fa8652da86769205f6e895167d304537403e169bcee1fd8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     build-essential \
     ca-certificates \
     libgtest-dev \
     libboost-test-dev \
     cmake \
     curl \
     g++ \
     gcc \
     git \
     wget \
     vim \
     zip \
  && rm -rf /var/lib/apt/lists/*
  
RUN mkdir /output

RUN git clone https://github.com/AlexeyAB/darknet.git

WORKDIR /darknet
