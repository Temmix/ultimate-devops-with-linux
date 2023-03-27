USER CATEGORIES

    Type of Users
        Superuser Account (root users)
        User Account (normal users)
        Service Account (apache, mySql)

1. to see the list of all the users on linux system
    cat /etc/passwd
        it will display, the username, placeholder for password, groupID and other info
    temmixx:x:1000:1000:Temmix,,,:/home/temmix:/bin/bash

2. add a new user to linux system
    sudo adduser temi
    enter all the necessary information it prompts you to
    
    then enter cat /etc/passwd  to see all the users
    temi:x:1001:1001:Temi Makinde, 212,07525637490,:/home/temi:/bin/bash

3. set password of a user
   sudo passwd temi
   follow the prompts and that is it

4. switch to another user or impersonate user
   su - temi (system will prompt you for password)
   su - johnson (system will prompt you for password)

5. switch to root user
   su - (system will prompt  you for the password)

6. add groups 
   sudo groupadd devops
   sudo groupadd developers

7. view the list of groups in linux system
   cat /etc/group

8. diff btw adduser, useradd and groupadd, addgroup and deluser userdel
   adduser, addgroup, deluser and delgroup ( are interactive and user friendly and for manual usage) while
   useradd, groupadd, userdel and groupdel ( You ll need to provide info when used and they are more low-level utilies)

9. change the group of a user
    sudo usermod -g devops temi
    sudo usermod -g developers temmix

10. delete group (these are default groups created when users were created)
    sudo delgroup temi
    sudo delgroup temmix

11. adding user to multiple groups
    sudo usermmod -G admins,devops temmix
    sudo usermod -G admins, devops temi

12. adding user to another group without overriding the existing group he/she belongs to before
    sudo usermod -aG developers

13. view the groups the current user belongs to
    groups
    admins developers

14. view the groups of any user
    groups temi
    groups temmix

15. add a user with any group straight away
    sudo useradd -G devops johnson

16. remove a user from a group
    sudo gpasswd -d temi admins

17. if having issue with deleting group, cos it is a primary group of a user,
    change the primary group of the user: sudo usermod -g developers johnson
    then delete the group in question: sudo delgroup johnson (default group when johnson user was created)

