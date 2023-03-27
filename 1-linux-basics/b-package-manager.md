PACKAGE MANAGER

1. sudo apt search openjdk

2. install a package using apt
        sudo apt install openjdk-11-jre-headless

3. remova a package using apt
        sudo apt remove openjdk-11-jre-headless

4. apt and apt-get
        apt and apt-get are both out of the box package manager in linux but
        apt is more user friendly, like progress bar and fewer and sufficient
        command options in a more organised way
        with apt-get you can achieve the same, if you use additional command 
        options, search command is not available in apt-get

5. install and remove java with apt-get
        sudo apt-get install openjdk-11-jre-headless
        sudo apt-get remove openjdk-11-jre-headless

6. first to do on linux system is to update the apt
        sudo apt update

7. other tools for installing software on linux systems includes:
       - ubuntu software (GUI)
       - snap (CLI), similar to apt
       - add Repository which are not official repositories yet
            - repository will be added to /etc/apt/sources.list
              e.g PPA = Personal Package Archive (be careful of this PPA)

8. install visual studio code with snap
        sudo snap install --classic code

9. diff between apt and snap
        snap is self contained -dependencies contained in the package, 
        supports universal linux packages with automatic updates and 
        has larger installation size
        apt has dependencies are shared and distributed, only specific
        linux distributions, manual updates and smaller installation 
        size.

10. diff linux distributions with the package manager
        Debian based  (they usually used apt and apt-get package manager) 
                Ubuntu
                Debian
                Mint
        Red Had based (they usually use the yum package manager)
                RHEL
                CentOS
                Fedora

