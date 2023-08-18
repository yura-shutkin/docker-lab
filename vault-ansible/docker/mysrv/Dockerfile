ARG DOCKER_REGISTRY
ARG REGISTRY_COMMON_STORAGE
ARG UBUNTU_VERSION

FROM ${DOCKER_REGISTRY}${REGISTRY_COMMON_STORAGE}ubuntu:${UBUNTU_VERSION}

RUN apt update && \
    apt -y install openssh-server && \
    mkdir /var/run/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
