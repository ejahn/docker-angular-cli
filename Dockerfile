# pull base image
FROM ubuntu:16.04
MAINTAINER Erik Jahn <erik@cmft.io>

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install updates, get packages
RUN apt-get update --fix-missing -y -qq
RUN apt-get install sudo
RUN sudo apt-get install -y build-essential libssl-dev curl wget software-properties-common

# Install git
RUN sudo apt-get install -y git git-core

# Install node
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# Install angular-cli
RUN sudo npm install -g @angular/cli

# Install nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 7

RUN wget -qO- https://raw.githubusercontent.com/xtuple/nvm/master/install.sh | sudo bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Add a user because we don't want to be root
RUN adduser --disabled-password --gecos "" angular; \
  echo "angular ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER angular

# install oh-my-zsh
RUN sudo apt-get install -y zsh
RUN sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN sudo cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# Create a directory for the app
RUN sudo mkdir -p /app && cd $_

WORKDIR /app
EXPOSE 4200

CMD ["zsh"]
