FROM centos:7

RUN yum install -y yum-utils

RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

RUN yum install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-20.10.18-3.el7.x86_64.rpm https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-cli-20.10.18-3.el7.x86_64.rpm https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.6.7-3.1.el7.x86_64.rpm https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-compose-plugin-2.10.2-3.el7.x86_64.rpm

ENV DEBUG=false

COPY modprobe startup.sh /usr/local/bin/
COPY supervisor/ /etc/supervisor/conf.d/

RUN chmod +x /usr/local/bin/startup.sh /usr/local/bin/modprobe
VOLUME /var/lib/docker

# set PS1 to only display "hostname $ " sign.
RUN echo "PS1='\h \$ '" >> /root/.bashrc

ENTRYPOINT ["startup.sh"]
CMD ["bash"]
