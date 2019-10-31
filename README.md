# [Dockerhub Repo](https://hub.docker.com/r/greglinscheid/polynote)
# [Official Polynote GitHub Repo](https://github.com/polynote/polynote) - [Release: 0.2.11](https://github.com/polynote/polynote/releases/tag/0.2.11)

## polynote
![Running Polynote Container](https://github.com/Vilos92/polynote/raw/master/example.png?raw=true?raw=true "Running Polynote Container")

This is an unofficial Docker image for Netflix's recently open sourced [polynote](https://polynote.org/).

The base image is alpine to reduce size. For convenience, the following Python libraries and their pre-requisites are also included:
- [PIL](https://pillow.readthedocs.io/en/stable/) for displaying images.
- [matplotlib](https://matplotlib.org/) for plotting data and rendering charts.

There is an additional Dockerfile, **Dockerfile.opencv**, which can be used to build a docker image with opencv dependencies already installed. You can pull these images by using the `opencv` tag.

## Usage
When running this image, expose port `8192` to access the web application at: http://localhost:8192/

**Example**: `docker run -p 8192:8192 --name=polynote -d -t greglinscheid/polynote:latest`

If you would like to mount a persistent volume for your notebooks, include the `-v` flag. The following example will mount the container's `notebooks/` directory to `$HOME/poly-notes`

**Example**: `docker run -p 8192:8192 -v $HOME/poly-notes:/usr/src/app/polynote/notebooks --name=polynote -d -t greglinscheid/polynote:latest`

If you would like to include opencv dependencies in your container, use the `opencv` tag instead:

**Example**: `docker run -p 8192:8192 -v $HOME/poly-notes:/usr/src/app/polynote/notebooks --name=polynote -d -t greglinscheid/polynote:opencv`

## Adding more packages
To add more packages, you can `exec` into the running container and install them.

**Python Example**:
```
docker exec -it polynote /bin/ash
pip3 install requests
```

For the above example, `requests` will be available without needing to restart the container.

For a solution which persists containers, it is recommended to create your own docker image. You can do this by either modifying `requirements.txt` and building the repository:

```
echo 'requests==2.22.0' >> requirements.txt
docker build -t greglinscheid/polynote:latest .
```

Or by creating a new Dockerfile which uses `greglinscheid/polynote` as the base:

```
FROM greglinscheid/polynote:latest
...
RUN pip3 install requests
```

## Scripts
For convenience, this repository includes shell scripts for building and running this image:
- `build_image.sh`
- `run_container.sh`
- `build_opencv_image.sh`
- `run_opencv_container.sh`

To build an image from the current repository, execute:

`sh build_image.sh`

To run the container and map the notebook directory to `$HOME/poly-notes`, execute:

`sh run_container.sh`

To build an image with opencv dependencies already installed, execute:

`sh build_opencv_image.sh`

To run the opencv container and map the notebook directory to `$HOME/poly-notes`, execute:

`sh run_opencv_image.sh`


## Links
- [Polynote's Home](https://polynote.org/).
- [Official Polynote GitHub Repo](https://github.com/polynote/polynote)
