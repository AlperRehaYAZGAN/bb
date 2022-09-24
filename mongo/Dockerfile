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
RUN yum install -y mongodb-org-server-5.0.12-1.el7.x86_64.rpm && rm mongodb-org-server-5.0.12-1.el7.x86_64.rpm
RUN yum install -y mongodb-org-shell-5.0.12-1.el7.x86_64.rpm && rm mongodb-org-shell-5.0.12-1.el7.x86_64.rpm

# copy files and give +x permission
COPY supervisor/docker.ini /etc/supervisord.d/
COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

# clean unused files
RUN yum clean all

# set PS1 to only display "hostname $ " sign.
RUN echo "PS1='\h \$ '" >> /root/.bashrc

ENTRYPOINT ["startup.sh"]
# Remove IPv6 alias for localhost and start docker in the background ...
CMD cat /etc/hosts >/etc/hosts.bak && \
    sed 's/^::1.*//' /etc/hosts.bak > /etc/hosts && \
    sed -i "s/\PWD_IP_ADDRESS/$PWD_IP_ADDRESS/" /etc/docker/daemon.json && \
    sed -i "s/\DOCKER_TLSENABLE/$DOCKER_TLSENABLE/" /etc/docker/daemon.json && \
    sed -i "s/\DOCKER_TLSCACERT/$DOCKER_TLSCACERT/" /etc/docker/daemon.json && \
    sed -i "s/\DOCKER_TLSCERT/$DOCKER_TLSCERT/" /etc/docker/daemon.json && \
    sed -i "s/\DOCKER_TLSKEY/$DOCKER_TLSKEY/" /etc/docker/daemon.json && \
    mount -t securityfs none /sys/kernel/security && \
    echo "root:root" | chpasswd &> /dev/null && \
    /usr/sbin/sshd -o PermitRootLogin=yes -o PrintMotd=no 2>/dev/null && \
    dockerd &>/docker.log & \
    while true ; do script -q -c "/bin/bash -l" /dev/null ; done
# ... and then put a shell in the foreground, restarting it if it exits