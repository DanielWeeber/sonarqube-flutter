FROM sonarqube:latest

MAINTAINER Daniel Weeber <daniel.weeber@twt.de>

USER root

RUN apt-get update \
  && apt-get install git -y
  && mkdir -p /home/sonarqube/.config
  && chown -R sonarqube:sonarqube /home/sonarqube

USER sonarqube
