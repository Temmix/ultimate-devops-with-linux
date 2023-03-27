BUILD TOOLS


JAVA APPLICATION 

- to build gradlew java application
    ./gradlew build

- to build maven application
    mvn install

- to run the gradlew java application on server, copy the jar file execute the ffg cmd
    java -jar build/libs/java-app-1.0-SNAPSHOT.jar

- to run the maven java application on server, copy the jar file and execute the ffg cmd
   java -jar target/java-maven-app-1.0-SNAPSHOT.jar





NODE JS

- to generate artefact file for js application
    npm pack



REMOTE TO DIGITAL OCEAN SERVER USING SSH

- Connect to server
        ssh -i ~/.ssh/temmix-key-rsa root@178.62.93.70

- Update ubuntu
        apt update

- Install Java
        apt install openjdk-8-jre-headless

- Install any tool on server by typing the name, linux system will give you the command to install it e.g
        : docker
            apt install docker.io      # version 20.10.12-0ubuntu4, or
            apt install podman-docker  # version 3.4.4+ds1-1ubuntu1
        : node
            apt install nodejs
        : netstat
            apt install net-tools

- Build gradlew application locally and copy to server
        ./gradlew build
        scp -i ~/.ssh/temmix-key-rsa build/libs/java-react-example.jar root@178.62.93.70:/root

- Run  jar file on server
        java -jar java-react-example.jar
    - or Run in silent mode
        java -jar java-react-example.jar & 

- Check if the application is running, if it is spinned up in silent mode
        ps aux | grep java
            root        3990 12.8 13.3 2156916 132776 pts/0  Sl   18:35   0:20 java -jar java-react-example.jar
            root        4017  0.0  0.2   7004  2160 pts/0    S+   18:38   0:00 grep --color=auto java

- Open port for SSH AND custom TCP for the application
- since the java application is using port 7071, we have to open this port on the firewall on the server
        SSH     TCP     22      YOUR IP
        CUSTOM  TCP     7071    All IPv4 All IPv6

- List all the server with active connection on the linux system using netstat
        netstat -lpnt

- Create a user on server, never use root user to do anything on the server
        adduser temi

- Add user temi to a sudo Group
        usermod -aG sudo temi

- Switch to user temi
    su - temi

- Create SSH for the new user, on the home/temi 
    mkdir .ssh
    ls -a
    sudo vim .ssh/authorized_keys

- Login with the new user temi
    ssh -i ~/.ssh/temmix-key-rsa temi@46.101.4.116

- Logout from user temi or root
    exit

