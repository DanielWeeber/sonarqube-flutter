FROM sonarqube:latest

MAINTAINER Daniel Weeber <daniel.weeber@twt.de>
ENV ANDROID_HOME /usr/lib/android-sdk
USER root
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/dart.gpg \
  && echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' > /etc/apt/sources.list.d/dart_stable.list
RUN apt-get update \
  && apt-get install software-properties-common apt-transport-https -y
RUN add-apt-repository ppa:maarten-fonville/android-studio -y
RUN apt-get update \
  && apt-get install dart gpg git curl file unzip xz-utils zip libglu1-mesa android-studio clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev android-sdk chromium-bsu -y \
  && mkdir -p /home/sonarqube/.config \
  && chown -R sonarqube:sonarqube /home/sonarqube
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip \
  && unzip commandlinetools-linux-6609375_latest.zip -d cmdline-tools \
  && mkdir --parents "$ANDROID_HOME/cmdline-tools/latest" \
  && mv cmdline-tools/* "$ANDROID_HOME/cmdline-tools/latest/"
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.9-stable.tar.xz \
  && tar xf flutter_linux_3.13.9-stable.tar.xz \
  && mv flutter /opt/flutter \
  && chown -R sonarqube:sonarqube /opt/flutter
RUN /opt/flutter/bin/flutter doctor --android-licenses --disable-telemetry
RUN git config --global --add safe.directory /opt/flutter

USER sonarqube
