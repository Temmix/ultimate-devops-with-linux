SSH 

to remotely connect to a remote server
go to the terminal and type the following (13Seikos)
: ssh root@ip-address
: ssh root@178.62.93.70

it will prompt you for the root/admin password, then boom you are on the server

1. Generate a ssh key and key enter till it is generated.
   : ssh-keygen -t rsa

2. list the ssh keys on the system
   : ls .ssh/
   id_rsa     id_rsa.pub

3. it is the id_rsa.pub which is the public key we need to share with the server
   
4. go to the server and ls .ssh
   : ls .ssh
   >> authoriszed_keys

5. then copy the content of .ssh/id_rsa from local system to the .ssh/authorized_keys 
   From local system
                : cat .ssh/id_rsa.pub
                copy the content from the terminal
   on server 
                : vim .ssh/authorized_keys
                enter i for insert mode and paste the content, esc key and :wq to write and quit the vim
                if you want to add multiple into this file authorized_keys, following the previous step, copy and leave a space on this file and paste the public ssh key into it

6. you can add another ssh key to your computer if you have id_rsa already by specifying the file name
   : ssh-keygen -f ~/.ssh/temmix-key-rsa -t rsa

7. if your ssh key is not id_rsa, you ll specify this when you want to ssh in into the server
   : ssh -i ~/.ssh/temmix-key-rsa root@178.62.93.70

8. copy file from local to remote serve
   : scp test.sh root@178.62.93.70:/root
   if with custom key
    : scp -i ~/.ssh/temmix-key-rsa test.sh root@178.62.93.70:/root

9. if you check the test.sh  and it has no execute permission
    : ls -la
    : chmod u+x test.sh

10. execute the script on the server
    : bash test.sh

11. 