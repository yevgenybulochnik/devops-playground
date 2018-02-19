# Docker Tutorial
Docker tutorial from the official [docker docs](https://docs.docker.com).

<details>
<summary><b>Part 1: Orientation</b></summary>

+ List Docker CLI commands
    ```
    docker
    docker version
    docker info
    ```
+ Display Docker version and info
    ```
    docker --version
    docker version
    docker info
    ```
+ Execute Docker image
    ```
    docker run <image-name>
    ```
+ List Docker images
    ```
    docker image ls
    ```
+ List Docker containers (running, all, all in quiet mode)
    ```
    docker container ls
    docker container ls -all
    docker container ls -a -q
    ```
</details>

<details>
<summary><b>Part 2: Containers</b></summary>

+ Build a Docker Image
    ```
    docker build -t <image-name> .
    ```
+ Run an Image
    ```
    docker run -p 4000:80 <image-name>      # port mapping 4000<host>:80<docker-process>
    docker run -d -p 4000:80 <image-name>   # run in detached mode
    ```
+ Container Commands
    ```
    docker container ls             # list running containers
    docker container ls -a          # list all containers
    docker container stop <hash>    # gracefully stop running container
    docker container kill <hash>    # force shutdown
    docker container rm <hash>      # remove container from machine
    docker container rm $(docker container ls -a -q) # remove all containers from machine
    ```
+ Image Commands
    ```
    docker image ls -a                      # List all images on this machine
    docker image rm <image id>              # Remove specified image from this machine
    docker image rm $(docker image ls -a -q)   # Remove all images from this machine
    ```
+ Docker Hub Commands
    ```
    docker login                                # Log in this CLI session using your Docker credentials
    docker tag <image> username/repository:tag  # Tag <image> for upload to registry
    docker push username/repository:tag         # Upload tagged image to registry
    docker run username/repository:tag          # Run image from a registry
    ```

</details>
