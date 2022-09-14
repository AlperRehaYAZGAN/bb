FROM centos:7

RUN yum install -y yum-utils

RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

RUN yum install -y yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin

ENV DEBUG=false

COPY modprobe startup.sh /usr/local/bin/
COPY supervisor/ /etc/supervisor/conf.d/

RUN chmod +x /usr/local/bin/startup.sh /usr/local/bin/modprobe
VOLUME /var/lib/docker

# set PS1 to only display "hostname $ " sign.
RUN echo "PS1='\h \$ '" >> /root/.bashrc

ENTRYPOINT ["startup.sh"]
CMD ["bash"]
