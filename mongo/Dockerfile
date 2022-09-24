FROM centos:7

RUN yum -y install epel-release
RUN yum -y install iptables supervisor

ENV DOCKER_VERSION=20.10.8 \
	DOCKER_COMPOSE_VERSION=1.29.2 \
	DEBUG=false

RUN set -eux; \
    curl -L https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -o docker.tgz && \
    tar --extract \
        --file docker.tgz \
        --strip-components 1 \
        --directory /usr/local/bin && \
    rm docker.tgz

# download rpm
RUN set -eux; \
    curl -L https://repo.mongodb.org/yum/redhat/7/mongodb-org/5.0/x86_64/RPMS/mongodb-org-shell-5.0.12-1.el7.x86_64.rpm  -o mongodb-org-shell-5.0.12-1.el7.x86_64.rpm

RUN set -eux; \
    curl -L https://repo.mongodb.org/yum/redhat/7/mongodb-org/5.0/x86_64/RPMS/mongodb-org-server-5.0.12-1.el7.x86_64.rpm  -o mongodb-org-server-5.0.12-1.el7.x86_64.rpm

# install from rpm locally
RUN yum install -y mongodb-org-server-5.0.12-1.el7.x86_64.rpm
RUN yum install -y mongodb-org-shell-5.0.12-1.el7.x86_64.rpm

# copy files and give +x permission
COPY supervisor/docker.ini /etc/supervisord.d/
COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

# set PS1 to only display "hostname $ " sign.
RUN echo "PS1='\h \$ '" >> /root/.bashrc

ENTRYPOINT ["startup.sh"]
CMD ["bash"]