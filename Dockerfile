# Kurento build and packaging tools for Ubuntu 16.04 (Xenial)
#
# This Docker image is used to build and generate Ubuntu packages (*.deb) of
# all repositories related to Kurento Media Server.

FROM buildpack-deps:xenial

# Configure environment:
# * LANG: Set the default locale for all commands
# * DEBIAN_FRONTEND: Disable user-facing questions and messages
# * PYTHONUNBUFFERED: Disable stdin, stdout, stderr buffering in Python
ENV LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

# CMake accepts the following build types: Debug, Release, RelWithDebInfo.
# So, for a debug build, you would run TYPE=Debug instead of TYPE=Release.
ENV TYPE=Release
ENV PATH="/adm-scripts:/adm-scripts/kms:$PATH"
ENV KMS_VERSION=6.9.0

# Configure apt-get:
# * Disable installation of recommended and suggested packages
# * Use the Openvidu package proxy
# * Fix issues with Node.js package repo
# * Add Kurento package repository
RUN echo 'APT::Install-Recommends "false";' >/etc/apt/apt.conf.d/00recommends \
 && echo 'APT::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
 && echo 'Acquire::http::Proxy "http://proxy.openvidu.io:3142";' >/etc/apt/apt.conf.d/01proxy \
 && echo 'Acquire::HTTP::Proxy::deb.nodesource.com "DIRECT";' >>/etc/apt/apt.conf.d/01proxy \
 && echo 'deb [arch=amd64] http://ubuntu.openvidu.io/6.9.0 xenial kms6' >/etc/apt/sources.list.d/kurento.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5AFA7A83 \
 && git clone https://github.com/Kurento/adm-scripts.git \
 && /adm-scripts/development/kurento-install-development \
 && /adm-scripts/development/kurento-install-packaging

COPY ./rootfs/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]






