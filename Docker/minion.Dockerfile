FROM debian
LABEL Author="daniel.karasinski@gmail.com"
LABEL version="1.0.0"
LABEL description="description of file"

RUN apt update -y
RUN apt upgrade -y

RUN apt update -y && \
    apt install -y curl
    
    
RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/debian/11/amd64/3004/salt-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/debian/11/amd64/3004 bullseye main" | tee /etc/apt/sources.list.d/salt.list

RUN apt update -y
RUN apt install -y salt-minion

COPY salt-data/configs/minion /etc/salt/minion
COPY salt-data/mine/mine.conf /etc/salt/minion.d/mine.conf

CMD ["salt-minion"]
