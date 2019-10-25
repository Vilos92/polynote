FROM alpine:3.10.3
LABEL maintainer="linscheid.greg@gmail.com"

WORKDIR /usr/src/app

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

# bash and socat are needed to run the polynote script
RUN apk add --no-cache bash socat

# Install OpenJDK
RUN apk add --no-cache openjdk8

# Install gcc (needed for python dependencies)
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
  ;

# Set PYTHONUNBUFFERED to avoid printing issues in running containers
ENV PYTHONUNBUFFERED=1

# Install Python and dependencies
RUN apk add python3-dev \
  & pip3 install jep jedi pyspark virtualenv matplotlib

# Clean gcc now that python dependencies are installled
RUN apk del \
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
  ;

# Download and extract polynote
RUN wget https://github.com/polynote/polynote/releases/download/0.2.8/polynote-dist.tar.gz \
  && tar -zxvpf polynote-dist.tar.gz

EXPOSE 8193

# polynote runs on 127.0.0.1:8192, so we use socat to map it to 0.0.0.0:8193
# TODO: This is hacky, should have polynote itself run on 0.0.0.0
CMD bash polynote/polynote & socat -d tcp-listen:8193,reuseaddr,fork tcp:127.0.0.1:8192
