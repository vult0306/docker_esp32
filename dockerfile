# Use Ubuntu 20.04 LTS as the basis for the Docker image.
FROM ubuntu:20.04

# Install all Linux packages required for Yocto builds as given in section "Build Host Packages"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y --purge && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y git wget flex bison gperf python3 python3-pip \
    python3-setuptools cmake ninja-build ccache libffi-dev libssl-dev dfu-util

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


ENV USER_NAME opener
ENV PROJECT sbo2
ARG host_uid=1002
ARG host_gid=1002
RUN groupadd -g $host_gid $USER_NAME && \
    useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME
RUN usermod -a -G dialout $USER_NAME

USER $USER_NAME
ENV YOCTO_BUILD_DIR /home/$USER_NAME/$PROJECT
RUN mkdir -p $YOCTO_BUILD_DIR

WORKDIR $YOCTO_BUILD_DIR

RUN git config --global user.name "wecheer_vle"
RUN git config --global user.email "vu.le@wecheer.io"

# docker build -t opener:init .
# docker run -it opener:init "/bin/bash"
# docker run -it -v /home/vle/gitwork/sbo2/:/home/opener/sbo2 opener:init "/bin/bash"

