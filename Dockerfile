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

# Configure apt-get:
# * Disable installation of recommended and suggested packages
# * Use the Openvidu package proxy
# * Fix issues with Node.js package repo
# * Add Kurento package repository
RUN git clone https://github.com/Kurento/adm-scripts.git \
 && /adm-scripts/development/kurento-repo-xenial-nightly-2018 \
 && /adm-scripts/development/kurento-install-development \
 && /adm-scripts/development/kurento-install-packaging

COPY ./rootfs/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]






