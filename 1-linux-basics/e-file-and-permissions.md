FILE OWNERSHIP AND PERMISSIONS

1.to see the permission on a file
    enter: ls -l
        drwxr-xr-x  16 Temmix  developers      512 26 Jul  2021 $RECYCLE.BIN
        -rw-r--r--@  1 Temmix  developers  6008843 30 May  2016 70-487.pdf

2. interpretation of the permission listed above
     drwxr-xr-x  16 Temmix  developers      512 26 Jul  2021 $RECYCLE.BIN
     -rw-r--r--@  1 Temmix  developers  6008843 30 May  2016 70-487.pdf

    the first character could be d or - (d: directory or -: file)
    rwx stand for (read write and execute permissions)

    after d or -, the first 3 characters rwx or r-x or -wx or rw- or r-- or --- : is for the user
                the second 3 characters rwx or r-x or -wx or rw- or r-- or --- : is for the group
                the third 3 characters rwx or r-x or -wx or rw- or r-- or --- : is for the others

3. to change the ownership of a file for user
        : sudo chown temi:devops config.yaml

4. you change the ownership of a file for group
        : sudo chown :devops config.yaml
        : sudo chgrp devops config.yaml

5. change permission for a user 
        : sudo chmod u+x config.yaml
        : sudo chmod u-x config.yaml

        : sudo chmod u=rwx config.yaml (add either of rwx)
        : sudo chmod u=rw- config.yaml (remove either of rwx)

6. change permission for a group 
        : sudo chmod g+x config.yaml
        : sudo chmod g-x config.yaml

        : sudo chmod g=--x config.yaml (add either of rwx)
        : sudo chmod g=r-x config.yaml (remove either of rwx)

7. change permission for others
        : sudo chmod o+x config.yaml
        : sudo chmod o-x config.yaml

        : sudo chmod o=--- config.yaml (add either of rwx)
        : sudo chmod o=rw- config.yaml (remove either of rwx)

