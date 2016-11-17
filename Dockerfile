# Ubuntu 15.10 Ansible-ready docker file
FROM ubuntu:15.10
MAINTAINER David E Oguche davideoguche@gmail.com
# Get git
RUN apt-get update
RUN apt-get install -y git build-essential
# 
RUN git clone git://github.com/Davazano/sci_gat
WORKDIR sci_gate
RUN echo "Repository was successfully cloned"

# Adding Oracle Java 7
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common
&& \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java7-installer

# Install zip and unzip
RUN apt-get install zip unzip


# Add Glassfish and Liferay
RUN curl -0 https://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.1.2%20GA3/liferay-portal-glassfish-6.1.2-ce-ga3-20130816114619181.zip/download && \ unzip liferay-portal-glassfish-6.1.2-ce-ga3-20130816114619181.zip && \ rm liferay-portal-glassfish-6.1.2-ce-ga3-20130816114619181.zip

# glassfish-3.1.2.2 to part
ENV PATH /usr/local/glassfish-3.1.2.2/bin:$PATH

# Change glassfish password
asadmin change-master-password

# start domain
asadmin start-domain

# Ensure ports are open
if [ sudo netstat -a | grep 4848 ]; then
	echo "Port 4848 is currently in use. Close it and try again."
fi

# Ensure ports are open
if [ sudo netstat -a | grep 8080 ]; then
	echo "Port 8080 is currently in use. Close it and try again."
fi

# Ensure ports are open
if [ sudo netstat -a | grep 8181 ]; then
	echo "Port 8181 is currently in use. Close it and try again."
fi

# Grid engines
RUN curl -0 http://grid.ct.infn.it/csgf/binaries/GridEngine/GridEngineDependencies.zip && \ unzip -d GridEngineDependencies.zip liferay-portal-glassfish-6.1.2-ce-ga3/glassfish-3.1.2.2/lib && \ rm GridEngineDependencies.zip

RUN curl -0 http://grid.ct.infn.it/csgf/binaries/GridEngine/jsaga-job-management-1.5.11.jar && \ 
mv jsaga-job-management-1.5.11.jar liferay-portal-glassfish-6.1.2-ce-ga3/glassfish-3.1.2.2/lib