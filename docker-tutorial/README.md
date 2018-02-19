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
    docker run -p 4000:80 <image-name> # port mapping 4000<host>:80<docker-process>
    docker run -d -p 4000:80 <image-name> # run in detached mode
    ```
+ Container Commands
    ```
    docker container ls # list running containers
    docker container ls -a # list all containers
    docker container stop <hash> # gracefully stop running container
    docker container kill <hash> # force shutdown
    docker container rm <hash> # remove container from machine
    docker container rm $(docker container ls -a -q) # remove all containers from machine
    ```

</details>
