FROM alpine:3.10.3
LABEL maintainer="linscheid.greg@gmail.com"

WORKDIR /usr/src/app

# curl is needed to download polynote script, bash is needed to run it
RUN apk add --no-cache bash curl

# Install OpenJDK
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
RUN apk add --no-cache openjdk8

# Install pre-requisites needed for python dependencies
RUN set -e; \
  apk add --no-cache --virtual \ 
    .build-deps \
    gcc \
    g++ \
    libc-dev \
    linux-headers \
    mariadb-dev \
    python3-dev \
    postgresql-dev \
    freetype-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    zlib-dev \
    jpeg-dev \
  ;

# Install Python and dependencies
ENV PYTHONUNBUFFERED=1
COPY requirements.txt ./requirements.txt
RUN apk add python3-dev \
  && pip3 install --upgrade pip \
  && pip3 install -r requirements.txt

# Download and extract polynote
ARG POLYNOTE_VERSION=0.2.15
RUN curl -L https://github.com/polynote/polynote/releases/download/${POLYNOTE_VERSION}/polynote-dist.tar.gz \
  | tar -xzvpf -

COPY config.yml ./polynote/config.yml

EXPOSE 8192

CMD bash polynote/polynote
