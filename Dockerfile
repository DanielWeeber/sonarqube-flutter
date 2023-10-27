FROM sonarqube:latest

MAINTAINER Daniel Weeber <daniel.weeber@twt.de>

USER root

RUN apt update \
  && apt install git -y

USER sonarqube
