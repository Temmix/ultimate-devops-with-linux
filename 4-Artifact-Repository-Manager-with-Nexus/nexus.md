NEXUS ( ARTIFACT REPOSITORY MANAGER )

Nexus only support java version 8

-- Install java 8 on the ubuntu system with 8GB Ram.

-- Move to the root path on the server
    cd opt/

-- Download nexus and run this on the terminal
    wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
    ls ==>  digitalocean  latest-unix.tar.gz

-- Untar the package downloaded and run this on terminal
    tar  -zxvf latest-unix.tar.gz
    ls ==> digitalocean  latest-unix.tar.gz  nexus-3.41.1-01  sonatype-work

-- For best practise, create nexus own user for the service on server, 
   never use root user to spin up nexus
    : adduser nexus

-- Check the owner permissions of the nexus folders
    : ls -l
        drwxr-xr-x  4 root root      4096 Aug 29 22:01 digitalocean
        -rw-r--r--  1 root root 216470874 Aug 19 10:47 latest-unix.tar.gz
        drwxr-xr-x 10 root root      4096 Aug 29 22:13 nexus-3.41.1-01
        drwxr-xr-x  3 root root      4096 Aug 29 22:13 sonatype-work

-- Give nexus user only the permission for that specific service
    :chown -R nexus:nexus nexus-3.41.1-01
    :chown -R nexus:nexus sonatype-work

-- Check the permission on the nexus files and folders 
    : ls -l
        drwxr-xr-x  4 root  root       4096 Aug 29 22:01 digitalocean
        -rw-r--r--  1 root  root  216470874 Aug 19 10:47 latest-unix.tar.gz
        drwxr-xr-x 10 nexus nexus      4096 Aug 29 22:13 nexus-3.41.1-01
        drwxr-xr-x  3 nexus nexus      4096 Aug 29 22:13 sonatype-work

-- Set Nexus configuration to run as nexus user
    : vim nexus-3.41.1-01/bin/nexus.rc
    set the run_as_user="nexus" and save it.

-- Switch to nexus user
    : su - nexus

-- Start the nexus service
    : /opt/nexus-3.41.1-01/bin/nexus start

-- Check and see Nexus is running
    : ps aux | grep nexus
    : netstat -lnpt
        Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
        tcp        0      0 127.0.0.1:40837         0.0.0.0:*               LISTEN      4325/java
        tcp        0      0 0.0.0.0:8081            0.0.0.0:*               LISTEN      4325/java
        tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      -
        tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -
        tcp6       0      0 :::22                   :::*                    LISTEN      -

-- Configure port 8081 in inbound Rules, in order to access nexus from the browser, as seen on the second tcp above
    Custom          TCP         8081        All IPv4 All IPv6

-- Check nexus on browser now
    http://46.101.4.116:8081/

-- Default admin user that comes with nexus, access the password
    : cat /opt/sonatype-work/nexus3/admin.password

-- Login on the UI, with admin and a6b0af4f-db56-4196-9046-ad57bbd053a8 as password
    this admin user on Nexus can create other users

-- The Nexus system on the UI will prompt you to change your admin password and some setting
    new password is 13Seikos



    REPOSITORY SECTION
There are 3 types of repository namely: Proxy, Group and Hosted

-- Proxy are the type of repository on nexus that acts like a link to remote repository. When a user tries to download a package from nexus, nexus will check if it has it locally, if yes send it to the user, but if no, the request will be sent to remote repository, remote repository will send it to nexus, send the response to the user, then nexus will cache it, making it available locally for anyone that requests for it in future.

-- Hosted are the type of repository that are hosted internally within the nexus, this is where we have all the artifacts for different application types. Users can access the artifacts jar files, packages from nexus.

-- Groups are the type of repository that allows you to configure other repositories together as one , that is use only one url to access multiple repository urls


PUBLISH ARTIFACT TO REPOSITORY

--We need to create a user from the UI, You first create the role nx-java with privilege as nx-repository-view-maven2-maven-snapshots-*
 then create the user with all the necessary information, assign the role as nx-java

-- You need to configure the maven and gradlew properties with necessary setting to interact with nexus 


-- FOR JAVA APP
 include the snippet in the build.gradle

publishing {
    publications {
        maven(MavenPublication) {
            artifact("build/libs/my-app-$version"+".jar") {
                extension 'jar'
            }
        }
    }
    repositories {
        maven {
            name "nexus"
            url "http://46.101.4.116:8081/repository/maven-snapshots/"
            allowInsecureProtocol(true)
            credentials {
                username project.repoUser
                password project.repoPassword
            }
        }
    }
}

--Note the project.repoUser and project.repoPassword, is like environment variable, not to expose credentials (These two are specified in gradle.properties file )
-- Build the app on the terminal by running the ffg 
        ./gradlew build

 --- Publish the artifact generated by running the ffg on the terminal
        ./gradlew publish



--FOR MAVEN APP
You need to configure the nexus credentials on maven project app
when in the maven project, follow this command on terminal
    : cd ~
    : ls -a | grep .m2
    : ls .m2
    : ls
     ==> repository (it should show)
    : vim settings.xml
    -- insert the following command into the settings.xml
    <settings>
        <servers>
            <server>
                <id>nexus-snapshots</id>
                <username>temi</username>
                <password>xxxx</password>
            </server>
        </servers>
    </settings>

and use vim to save the settings.xml

Now configure the pom.xml to be similar to the pom.xml in this folder
which has all the necessary nexus url and things for deployment.

-- To build maven app
    : mvn install

-- To deploy maven artifact
    : mvn deploy

    

