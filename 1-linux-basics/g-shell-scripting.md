SHELL SCRIPTING

All shell script files have the same .sh file extension

1. How does OS know which shell to use ( SHELL, BASH OR ZSHELL )?
    sh  => #!/bin/sh
    bash  => #!/bin/bash
    zsh  => #!/bin/zsh

2. At the top of the sh file, you specify which shell to use
   #!/bin/bash

3. #! is called shebang

4. create a shell file with simple script
    touch intro.sh
    vim intro.sh

    by default user, wont have execute right on file, 
    so we need to change the permission on the file as follows
    sudo chmod u=rwx intro.sh

    The file should contain the ffg:
    #!/bin/bash
        echo "--------- setup and configuring server on AWS ----------------"
    
    then you can run it as follow on linux system
        ./intro.sh or
        bash intro.sh


