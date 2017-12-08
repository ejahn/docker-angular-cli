# docker-angular-cli
node:8 image and angular-cli

## Description

**Usage:**

This command: "$ docker run -it -p 4200:4200 --rm -v $(pwd):/home/node/app ejahn/docker-angular-cli"
* Starts the container
* Maps the exposed server- and livereload ports
* Mounts the working directory to your current local directory

Hint:
You need to use '0.0.0.0' as host to have access from outside
