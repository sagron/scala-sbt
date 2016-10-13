#
# Scala and sbt Dockerfile
#
# https://github.com/hseeberger/scala-sbt
#

# Pull base image
FROM java:latest

ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.12
ENV SCALA_HOME /usr/local/share/scala

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C $SCALA_HOME && \
  ln -sf scala-$SCALA_VERSION $SCALA_HOME/scala && \
  echo '#!/bin/bash' > /etc/profile.d/scala.sh && \
  echo 'export PATH=$SCALA_HOME/bin:$PATH' >> /etc/profile.d/scala.sh

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

# Define working directory
WORKDIR /root
