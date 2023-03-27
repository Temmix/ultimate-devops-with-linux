

DOCKER COMMANDS

PUll image from the repository
    - docker pull imageName

Check the images
    - docker images

Run a container from the image
    - docker run imageID/imageName   --name custom-image-name
  
Check the containers
    - docker ps
    - docker ps -a  (for both running and not running containers)

Start a container
    - docker start containerID
  
Stop a container
    - docker stop containerID


BINDING PORT

docker run -p 6000:6379  -d fcf69b8f437c
    Note -p hostPort:ContainerPort

Difference between docker run and docker start

docker run is for images, you can specify other options -d, -p, --name, -it

docker start is for already created and stopped container to restart it, and it will restart with the old options specified when container was created.