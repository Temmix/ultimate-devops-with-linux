Installing Jenkins as a docker container on server
username:temi and password:13Seikos
1. Create an ubuntu server on digital ocean drop minimum of 4GB Ram
2. create a firewall for it open SSH port 22 and custom with port 8080 and add this droplet to the firewall

3. ssh into the server, apt update the server and install docker (type docker on the cmd and enter) the right
   command for the installations will be lister e.g (apt install docker.io)

4. spin up the jenkins container with the following command on the cmd on server
   docker run -p 8080:8080 -p 50000:50000 -d -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts 

5. go on your browser, type the ip address of the server:8080  (Getting started page)
   then you can unlock the jenkins with the password in the following server path (/var/jenkins_home/secrets/initialAdminPassword)
   use the following to get into the container and copy the password from the above jenkins_home path
            docker exec -it `container ID` d344ryt7u5uu4d bash
            cat /var/jenkins_home/secrets/initialAdminPassword
            46dfb584a63b4b47bb76acec9b3a4404

6. create the first user and setup the credentials, then jenkins is ready to be used.
   
7. Installing plugins for jenkins can be in 2 ways
    a. Through the Manage Jenkins > Global configuration Tools page
    b. Ssh into the docker container as a root user and install plugins directly in there
        docker exec -u 0 -it d344ryt7u5uu4d bash
         cat /etc/issue
            ==> Debian GNU/Linux 11 \n \l
        apt update
        apt install curl
        curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh

        apt install nodejs
        apt install npm

8. Track where jenkins store the files from gitlab or github
        docker exec -it afcf978f6e32 bash
        ls /var/jenkins_home/workspace   (this will show all the job folder which contains the files from github or gitlab)

9. To make docker available inside the jenkins container, we have to kill the current container and remount it with docker volume
        docker stop afcf978f6e32

        docker run -p 8080:8080 -p 50000:50000 -d \
        -v jenkins_home:/var/jenkins_home \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v $(which docker):/usr/bin/docker jenkins/jenkins:lts

10. Give jenkins user permission to do stuffs with docker as it was mounted from server into the container.
        docker exec -u 0 -it `container ID` bash
        chmod 666 /var/run/docker.sock

11. Install kubectl in jenkins using curl
        docker exec -u 0 -it `container ID` bash
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        chmod +x ./kubectl
        mv ./kubectl  /usr/local/bin/kubectl

12. Check kubectl version in jenkins now
        kubectl version

13. Download aws-iam-authenticator in the jenkins container
        curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64

        chmod +x ./aws-iam-authenticator
        mv ./aws-iam-authenticator  /usr/local/bin/

        exit from the jenkins containers now

14. Create config file for kube config
    
-----------------------------------------------
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: <$certificate_data>
    server: <$cluster_endpoint>
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "temmix-cluster"
  
-----------------------------------------------------

You can now change t he server and certificate authority-data values
server is from aws eks public end point
certificate-authority-data will be extracted from our local .kube/config file

extract like follows
    cat .kube/config

15. On droplet server use vim to create a config and paste the above config and fill out the missing information
    vim config

16. Move into the jenkins container
        docker exec -it afcf978f6e32 bash
        cd ~
        pwd
        mkdir .kube
        then exit
    On the droplet server :
        docker cp config afcf978f6e32:/var/jenkins_home/.kube/