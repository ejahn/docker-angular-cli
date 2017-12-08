FROM node:8

ENV APP_USER node
ENV APP_FOLDER /home/$APP_USER/app
RUN apt-get update --fix-missing -y -qq
RUN apt-get install sudo
RUN apt-get install -y build-essential libssl-dev curl wget software-properties-common git git-core zsh
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# change standard shell to zsh
RUN chsh $APP_USER -s $(which zsh);

RUN echo "$APP_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# interact as app user
USER $APP_USER

# install oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# avoid node permission issues
RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
RUN npm install -g @angular/cli

RUN mkdir -p $APP_FOLDER
WORKDIR $APP_FOLDER

CMD ["zsh"]
