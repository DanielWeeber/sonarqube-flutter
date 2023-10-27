FROM sonarqube:latest

MAINTAINER Daniel Weeber <daniel.weeber@twt.de>
ENV ANDROID_HOME /usr/lib/android-sdk
USER root
RUN apt-get update \
  && apt-get install software-properties-common -y
RUN add-apt-repository ppa:maarten-fonville/android-studio -y
RUN apt-get update \
  && apt-get install git curl file unzip xz-utils zip libglu1-mesa android-studio clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev android-sdk chromium-bsu -y \
  && mkdir -p /home/sonarqube/.config \
  && chown -R sonarqube:sonarqube /home/sonarqube \
  && git config --global --add safe.directory /opt/sonarqube/extensions/flutter
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip \
  && unzip commandlinetools-linux-6609375_latest.zip -d cmdline-tools \
  && mkdir --parents "$ANDROID_HOME/cmdline-tools/latest" \
  && mv cmdline-tools/* "$ANDROID_HOME/cmdline-tools/latest/"
RUN flutter doctor --android-licenses --disable-telemetry

USER sonarqube
