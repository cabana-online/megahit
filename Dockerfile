FROM cabanaonline/ubuntu:1.0

LABEL base.image="cabanaonline/alpine"
LABEL description="A MEGAHIT container."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

ARG USER=cabana
ENV HOME /home/$USER

USER root

# Install python.
RUN set -xe; \
    apt-get install -y python && \
    apt-get clean && \
    apt-get autoclean;

# Installs MEGAHIT.
RUN set -xe; \
    \
    cd $HOME/tools && \
    wget https://github.com/voutcn/megahit/releases/download/v1.2.9/MEGAHIT-1.2.9-Linux-x86_64-static.tar.gz && \
    tar zvxf MEGAHIT-1.2.9-Linux-x86_64-static.tar.gz && \
    mv MEGAHIT-1.2.9-Linux-x86_64-static MEGAHIT && \
    cd /usr/bin && \
    ln -s $HOME/tools/MEGAHIT/bin/megahit megahit;

# Reverts to standard user.
USER cabana

# Entrypoint to keep the container running.
ENTRYPOINT ["tail", "-f", "/dev/null"]
