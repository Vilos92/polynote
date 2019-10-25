# https://hub.docker.com/r/greglinscheid/polynote                                                                

## polynote

This is an unofficial Docker image for Netflix's recently open sourced [polynote](https://polynote.org/).

The base image is alpine to reduce size. matplotlib is compiled and included as well.

## Usage

When running this image, expose port `8192` to access the web application at: http://localhost:8192/

**Example**: `docker run -p 8192:8192 --name=polynote -d -t greglinscheid/polynote:latest`

If you would like to mount a persistent volume for your notebooks, include the `-v` flag.

**Example**: `docker run -p 8192:8192 -v poly-notes:/usr/src/app/polynote --name=polynote -d -t greglinscheid/polynote:latest`

For convenience, this repository includes two shell scripts to build and run this image: `build_image.sh` and `run_container.sh`
