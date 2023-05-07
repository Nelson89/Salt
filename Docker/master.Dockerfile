FROM debian
LABEL Author="daniel.karasinski@gmail.com"
LABEL version="1.0.0"
LABEL description="Image with salt-master process"

RUN apt update -y
RUN apt upgrade -y

RUN apt update -y && \
    apt install -y vim && \
    apt install -y net-tools && \
    apt install -y curl && \
    apt install -y procps && \
    apt install -y inetutils-ping && \
    apt install -y iproute2 && \
    apt install -y gpg && \
    apt install -y wget && \
    apt install -y tree
    
RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/debian/11/amd64/3004/salt-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/debian/11/amd64/3004 bullseye main" | tee /etc/apt/sources.list.d/salt.list

RUN apt update -y
RUN apt install -y salt-master && \
    apt install -y salt-ssh

RUN mkdir -p /home/salt
RUN mkdir -p /srv/salt/prod/states
RUN mkdir -p /srv/salt/tests/states
RUN mkdir -p /srv/salt/qa/states
RUN mkdir -p /srv/pillar

COPY salt-data/configs/master.conf /etc/salt/master.d/root.conf
COPY salt-data/auto/start_test.sh /home/salt
RUN chmod u+x /home/salt/start_test.sh

# Prepare pillar
COPY salt-data/pillar/go_version.sls /srv/pillar/
COPY salt-data/pillar/top.sls /srv/pillar/

# Prepare base env
COPY salt-data/states/top.sls.base /srv/salt/top.sls
COPY salt-data/states/php81 /srv/salt/php81
COPY salt-data/states/vim /srv/salt/vim
COPY salt-data/states/tools.sls /srv/salt/
COPY salt-data/states/less.sls /srv/salt/
COPY salt-data/states/procps.sls /srv/salt/
COPY salt-data/states/tree.sls /srv/salt/
COPY salt-data/states/go_binary /srv/salt/go_binary

# Prepare production env
COPY salt-data/states/top.sls.prod /srv/salt/prod/states/top.sls
COPY salt-data/states/php81 /srv/salt/prod/states/php81
COPY salt-data/states/vim /srv/salt/prod/states/vim
COPY salt-data/states/tools.sls /srv/salt/prod/states/
COPY salt-data/states/procps.sls /srv/salt/prod/states/
COPY salt-data/states/tree.sls /srv/salt/prod/states/
COPY salt-data/states/less.sls /srv/salt/prod/states/

# Prepare tests env
COPY salt-data/states/top.sls.tests /srv/salt/tests/states/top.sls
COPY salt-data/states/php81 /srv/salt/tests/states/php81
COPY salt-data/states/vim /srv/salt/tests/states/vim
COPY salt-data/states/tools.sls /srv/salt/tests/states/
COPY salt-data/states/tree.sls /srv/salt/tests/states/
COPY salt-data/states/procps.sls /srv/salt/tests/states/
COPY salt-data/states/less.sls /srv/salt/tests/states/
COPY salt-data/states/go_binary /srv/salt/tests/states/go_binary

# Prepare QA env
COPY salt-data/states/top.sls.qa /srv/salt/qa/states/top.sls
COPY salt-data/states/less.sls /srv/salt/qa/states/

WORKDIR /home/salt

CMD ["salt-master"]
