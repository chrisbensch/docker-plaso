FROM ubuntu:bionic
#MAINTAINER Log2Timeline <log2timeline-dev@googlegroups.com>
#Based on the work of log2timeline, all credit to them for original Dockerfile
LABEL maintainer="chris.bensch@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt -y update
RUN apt -y install apt-transport-https apt-utils
RUN apt -y install libterm-readline-gnu-perl software-properties-common
RUN add-apt-repository -y ppa:gift/stable

RUN apt -y update
RUN apt -y upgrade

RUN apt -y install locales plaso-tools

# Clean up apt cache files
RUN apt clean && apt autoremove && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

# Set terminal to UTF-8 by default
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /usr/local/bin
COPY "plaso-switch.sh" "plaso-switch.sh"
RUN chmod a+x plaso-switch.sh

VOLUME ["/data"]

WORKDIR /home/plaso/

ENTRYPOINT ["/usr/local/bin/plaso-switch.sh"]
