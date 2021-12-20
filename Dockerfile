FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y tzdata
ENV TZ=Asia/Tokyo 

RUN apt update && \
    apt upgrade -y && \
    apt install -y sudo \
                wget \
                curl \
                build-essential \
                cmake \
                libsm6 \
                libxrender1 \
                libxext-dev \
                x11-apps \
                libgl1-mesa-dev \
                libgtk2.0-dev \
                libxtst6

WORKDIR /tmp
RUN wget https://github.com/processing/processing4/releases/download/processing-1277-4.0b2/processing-4.0b2-linux64.tgz && \
    tar -xzvf processing-4.0b2-linux64.tgz && \
    mv processing-4.0b2 /opt && \
    rm -rf /tmp/processing-4.0b2-linux64.tgz
                
ARG DOCKER_UID=1000
ARG DOCKER_USER=docker
ARG DOCKER_PASSWORD=docker
RUN useradd -m \
    --uid ${DOCKER_UID} --groups sudo --shell /bin/bash ${DOCKER_USER} \
    && echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd

WORKDIR /home/${DOCKER_USER}/work

RUN chown -R ${DOCKER_USER} ./

USER ${DOCKER_USER}