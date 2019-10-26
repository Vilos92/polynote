# https://hub.docker.com/r/greglinscheid/polynote                                                                

## polynote

![Running Polynote Container](/example.png?raw=true "Running Polynote Container")

This is an unofficial Docker image for Netflix's recently open sourced [polynote](https://polynote.org/).

The base image is alpine to reduce size. matplotlib is compiled and included as well.

## Usage

When running this image, expose port `8192` to access the web application at: http://localhost:8192/

**Example**: `docker run -p 8192:8192 --name=polynote -d -t greglinscheid/polynote:latest`

If you would like to mount a persistent volume for your notebooks, include the `-v` flag.

**Example**: `docker run -p 8192:8192 -v poly-notes:/usr/src/app/polynote/notebooks --name=polynote -d -t greglinscheid/polynote:latest`

For convenience, this repository includes two shell scripts to build and run this image: `build_image.sh` and `run_container.sh`

## Adding more packages

To add more packages, you can `exec` into the running container and install them.

**Python Example**: 

```
docker exec -it polynote /bin/ash
pip3 install --no-cache requests
```

For the above example, `requests` will be available without needing to restart the container.

For a solution which persists containers, it is recommended to create your own docker image:

```
FROM greglinscheid/polynote:latest
...
RUN pip3 install --nocache requests
```
