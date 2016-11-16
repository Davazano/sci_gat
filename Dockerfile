# Ubuntu 15.10 Ansible-ready docker file
FROM ubuntu:15.10
MAINTAINER David E Oguche
# Get git
RUN apt-get update
RUN apt-get install -y git build-essential
#
RUN git clone git://github.com/Davazano/sci_gat
WORKDIR sci_gate
RUN cat README.md