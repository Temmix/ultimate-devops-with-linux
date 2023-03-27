BASIC LINUX COMMANDS

1. show working directory
    pwd 
    /home/temmix

2. list everything in working directory
    ls
    Desktop  Download   Pictures  Templates etc

3. change directory
    cd Desktop

4. Logged User with $ (member user) and # (root user)

5. go up one folder
   cd ..

6. make a directory inside the Document folder
   mkdir python-project

7. make a file inside a directory python-project
   cd python-project
   touch readMe.md

8. remove a file from a directory
   rm readMe.md

9. remove a directory with -r flag (recursive)
    cd ..
    rm -r python-project

10. navigate to root folder
    cd  /

11. navigate to anywhere in root dir from anywhere
    cd  /usr

12. navigate to home directory
    cd  ~

13. list content of a dir without switching into the directory
    ls  /etc/security

14. change directory name in Documents from python-project to java-project
    mv  python-project  java-project

15. copy directory with content to another one (with -r - recursive)
    cp -r java-project  my-project 

16. copy file name inside the my-project directory
    cp read.md readMe.test.md

17. rename a file to another name
    mv read.Me read.dev.md

18. if you want to see all the content of all directories inside the Documents dir
    ls -R Documents

19. if you want to see the History of your command Line
    history

20. see the last 5 cmd from history
    history 5

21. display hidden files
    ls -a
    ls -a  /tmp

22. view content of a file/hidden file
    cat ~/bashrc
    cat Documents/java-app/ReadMe.md

23. display OS information
    uname -a
    cat /etc/os-release

24. display information about the hardware of your machine
    lscpu

25. display memory information
    lsmem

26. add user to your machine (you have to run this as an super user)
    su adduser admin

27. switch user from one to another user (this will prompt for password of the user account)
    su - admin
    su - temmix

28. view all the cmd from .bash_history
    cat /home/temmix/.bash_history