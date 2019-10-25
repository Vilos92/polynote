FROM alpine:3.10.3
LABEL maintainer="linscheid.greg@gmail.com"

WORKDIR /usr/src/app

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

# Install OpenJDK
RUN apk add openjdk8

# Install gcc (needed for python dependencies)
RUN apk add --no-cache --virtual .build-deps gcc musl-dev

# Set PYTHONUNBUFFERED to avoid printing issues in running containers
ENV PYTHONUNBUFFERED=1
RUN apk add python3-dev

RUN pip3 install jep jedi pyspark virtualenv

# Clean gcc now that python dependencies installled
RUN apk del .build-deps gcc musl-dev

# Download and extract polynote
RUN wget https://github.com/polynote/polynote/releases/download/0.2.8/polynote-dist.tar.gz
RUN tar -zxvpf polynote-dist.tar.gz

RUN apk add bash

WORKDIR /usr/src/app/polynote

CMD ["bash", "polynote"]
