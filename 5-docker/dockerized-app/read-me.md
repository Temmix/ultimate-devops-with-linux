
Docker Network

For all docker containers, they can connect with one another by using their container name, outside of the network you will need to use port number and the rest

list all the docker network on terminal
    : docker network ls

to create a new network on docker
    : docker network create mongo-network

to spin up the mongo with environment variables
    : docker run -p 27017:27017 -d -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password --name mongoDB  --net mongo-network mongo

to spin up the mongo-express with environment variables
    : docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin -e ME_CONFIG_MONGODB_ADMINPASSWORD=password --net mongo-network --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongoDB mongo-express 

to view the mongo container logs 2cec8c9fc22f(containerID)
    : docker logs 2cec8c9fc22f
    : docker logs 2cec8c9fc22f | tail
    : docker logs 2cec8c9fc22f -f ( You can put line as the end of the call and see the new api call when made)


docker-compose helps to spin up multiple containers and create internal network between them by default.

to spin up multiple containers
    :  docker-compose -f  docker-compose.yaml up

to stop multiple containers
    :  docker-compose -f  docker-compose.yaml down

build image from local application using a Dockerfile
    : docker build -t my-app:1.0 .

delete docker image
    : docker rmi 45bc5b9d546d (imageID)

delete docker container
    : docker rm ui7893ijkasd (ContainerID)


PUSHING DOCKER IMAGES TO AWS ECR (Elastic Container Registry)

Retrieve an authentication token and authenticate your Docker client to your registry.
Use the AWS CLI:

aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 224922007415.dkr.ecr.eu-west-2.amazonaws.com
Note: if you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.
Build your Docker image using the following command. For information on building a Docker file from scratch, see the instructions here . You can skip this step if your image has already been built:

docker build -t my-app:1.2 .
After the build is completed, tag your image so you can push the image to this repository:

docker tag my-app:1.0 224922007415.dkr.ecr.eu-west-2.amazonaws.com/my-app:1.0
Run the following command to push this image to your newly created AWS repository:

docker push 224922007415.dkr.ecr.eu-west-2.amazonaws.com/my-app:1.0

PUSHING INTO DOCKER HUB
    docker build -t temmix/react-nodejs-example:1.0 .
    docker push temmix/react-nodejs-example:1.0