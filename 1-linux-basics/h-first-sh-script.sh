 #!/bin/bash

echo "--------- setup and configuring server on AWS ----------------"

file_name=config.yaml
# Passing parameter from the console using $1
config_dir=$1

if [ -d "$config_dir" ]
then
    echo "reading the config directory contents"
    config_files=$(ls "$config_dir")
else
    echo "config dir  not found. Creating on ..."
    mkdir "$config_dir"
    touch "$config_dir/index.html"
fi

# Passing parameter from the console using $2
user_group=$2
if [ "$user_group" == "Femi" ]
then
    echo "configure the server by Temi"
elif [ "$user_group" == "admin" ]
then 
    echo "administering the server"
else
    echo "No permission to configure the server. Wrong user group"
fi

echo "using file $file_name to configure ubuntu on the server"

echo "here are all the configuratin files"


# run the script by running bash h-firstsh-script.sh configuration admin