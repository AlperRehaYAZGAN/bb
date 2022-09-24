FROM centos:7

RUN yum -y install epel-release
RUN yum -y install iptables

# download rpm
RUN set -eux; \
    curl -L https://repo.mongodb.org/yum/redhat/7/mongodb-org/5.0/x86_64/RPMS/mongodb-org-shell-5.0.12-1.el7.x86_64.rpm  -o mongodb-org-shell-5.0.12-1.el7.x86_64.rpm

RUN set -eux; \
    curl -L https://repo.mongodb.org/yum/redhat/7/mongodb-org/5.0/x86_64/RPMS/mongodb-org-server-5.0.12-1.el7.x86_64.rpm  -o mongodb-org-server-5.0.12-1.el7.x86_64.rpm

# install from rpm locally
RUN yum install -y mongodb-org-server-5.0.12-1.el7.x86_64.rpm && rm mongodb-org-server-5.0.12-1.el7.x86_64.rpm
RUN yum install -y mongodb-org-shell-5.0.12-1.el7.x86_64.rpm && rm mongodb-org-shell-5.0.12-1.el7.x86_64.rpm

# copy files and give +x permission
COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

# clean unused files
RUN yum clean all

# set PS1 to only display "hostname $ " sign.
RUN echo "PS1='\h \$ '" >> /root/.bashrc

ENTRYPOINT ["startup.sh"]
CMD ["bash"]