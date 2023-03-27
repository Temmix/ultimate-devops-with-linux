CREATE EC2 ON AWS
Create EC2 with configuration of your choice like image type, volume, number of volume and the rest



DOWNLOAD THE PEM FILE FOR CONNECTION THROUGH SSH
From your local file, move the pem file into ssh folder
   sudo : could prefix with sudo if you dont have admin right
        mv ~/Download/something-file.pem ~/.ssh/ 


CHANGE THE PERMISSION OF THE PEM FILE
    ls -l ~/.ssh/temmix-web-server-with-docker.pem
        -rw-r--r--@ 1 Temmi  staff  1674 16 Jan 23:15 /Users/Temmi/.ssh/temmix-web-server-with-docker.pem
        chmod 400 ~/.ssh/temmix-web-server-with-docker.pem (this prevents errors from the aws ec2)
    ls -l ~/.ssh/temmix-web-server-with-docker.pem
        -r--------@ 1 Temmi  staff  1674 16 Jan 23:15 /Users/Temmi/.ssh/temmix-web-server-with-docker.pem


CONNECT THROUGH SSH
ssh -i ~/.ssh/temmix-web-server-with-docker.pem ec2-user@13.40.16.121


FOLLOW THE FOLLOW COMMAND WHEN YOU CONNECT ON EC2 FOR THE FIRST TIME
    sudo yum update
    sudo yum install docker
        docker --version

    Start the docker deamon
        sudo service docker start
    
    Check if docker is running
        ps aux | grep docker

    Make the ec2-user into the docker group (no need for sudo prefix on cmd)
        sudo usermod -aG docker $USER


Build a docker image and push into docker hub
    docker build -t temmix/react-nodejs-example:1.0 .
    docker push temmix/react-nodejs-example:1.0


CONTINUE ON THE EC2 TERMINAL
    docker login
    docker pull temmix/react-nodejs-example:1.0
    docker run -d -p 3000:3080 temmix/react-nodejs-example:1.0


EDIT THE SECURITY GROUP TO OPEN PORT 3000 FOR THE APPLICATION
    Edit the inbound rule Custom TCP Port 3000 source : 0.0.0.0/0