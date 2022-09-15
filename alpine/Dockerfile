FROM alpine:3.15

# Install Docker and dependencies
RUN apk --update add \
  bash \
  iptables \
  ca-certificates \
  e2fsprogs \
  docker \
  openssh-client wget curl iptables supervisor \
  && rm -rf /var/cache/apk/*



# Define additional metadata for our image.

# Docker compose installation
RUN curl -L "https://github.com/docker/compose/releases/download/v2.10.1/docker-compose-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m)" -o /usr/local/bin/docker-compose \
	&& chmod +x /usr/local/bin/docker-compose && docker-compose version

RUN apk-install docker bash \
    && curl -sL https://get.docker.com/builds/$(uname -s)/$(uname -m)/docker-1.12.6.tgz | tar -xz -C /usr/local/bin --strip-components=1 \
    && chmod +x /usr/bin/docker \
    && curl -sL https://github.com/docker/docker/raw/master/hack/dind > /usr/local/bin/dind \
    && chmod +x /usr/local/bin/dind

VOLUME /var/lib/docker

# set PS1 to only display "hostname $ " sign.
RUN echo "PS1='\h \$ '" >> /root/.bashrc

CMD ["dind", "docker", "daemon","bash"]
