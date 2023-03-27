ENVIRONMENT VARIABLES


1. to see all the env variables
   : printenv

2. to see specific env variable
   : printenv USER
   : printenv SHELL
   : echo $USER
   : echo $SHELL

3. setting/update environment variables
   : export APPLICATION_NAME_DB_USERNAME=dbUser
   : export APPLICATION_NAME_DB_PASSWORD=secretpwdvalue
   : export APPLICATION_NAME_DB_URL=mySqlDb
   : printenv | grep APPLICATION

4. remove environment variable
   : unset APPLICATION_NAME_DB_USERNAME

5. to permanent persist environment variable , you need to add it to the following file using vim
   : for bash   ==> vim ~/.bashrc
   : for zsh    ==> vim ~/.zshrc

4. if you want to see the environment variable changes on the session we are, reload/update the .bashrc 
   : source ~/.bashrc