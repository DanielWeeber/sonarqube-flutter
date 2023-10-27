FROM sonarqube:latest

MAINTAINER Daniel Weeber <daniel.weeber@twt.de>

USER root
RUN apt-get update \
  && apt-get install software-properties-common -y
RUN add-apt-repository ppa:maarten-fonville/android-studio -y
RUN apt-get update \
  && apt-get install git curl file unzip xz-utils zip libglu1-mesa android-studio clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev android-sdk chromium-bsu -y \
  && mkdir -p /home/sonarqube/.config \
  && chown -R sonarqube:sonarqube /home/sonarqube

USER sonarqube
