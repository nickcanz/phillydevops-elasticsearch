phillydevops-elasticsearch
==========================

## Installation and Setup

1. Install [Docker](https://www.docker.io/gettingstarted/#h_installation). On OSX, I'm using [boot2docker](http://docs.docker.io/en/latest/installation/mac/#boot2docker). For verification, `docker version` should return a version.
1. Build the custom elasticsearch docker image, with a tag of `devops-es`.
    docker build -t devops-es elasticsearch-dockerfile/Dockerfile
1. Pull down the couchdb docker image
    docker pull klaemo/couchdb
