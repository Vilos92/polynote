# https://cloud.docker.com/repository/registry-1.docker.io/greglinscheid/polynote

## polynote

This is an unofficial Docker image for Netflix's recently open sourced [polynote](https://polynote.org/).

The base image is alpine to reduce size. matplotlib is compiled and included as well.

## Usage

This repository includes two shell scripts to build and run this image: `build_image.sh` and `run_container.sh`

When running this image, expose port `8193` to access the web application.
