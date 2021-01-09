FROM ubuntu:18.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    sudo htop tree

RUN  useradd doby && echo "doby:pw" | chpasswd && adduser doby sudo
USER doby
WORKDIR /home/doby
