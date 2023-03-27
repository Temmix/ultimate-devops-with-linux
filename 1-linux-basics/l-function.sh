 #!/bin/bash

echo "--------- FUNCTIONS ----------------"


function score_sum {
    sum=0
    while true
        do 
        read -p "enter a score " score
        
        if [ "$score" == "q" ]
        then 
            break
        fi 
    
    sum=$(($sum+$score))
    echo "The total score now is: $score"
    done
}

score_sum

function create_file () {
    file_name=$1
    is_shell_script=$2

    touch $file_name
    echo "file $file_name created"
    if [ "$is_shell_script" == true ]
        then 
            chmod u+x $file_name
            echo "Added file with execute permission"
    fi
}

create_file temidayo.sql
create_file ollie.md 
create_file grannex.sh true 
create_file yungie.sh false

function sum () {
    total=$(($1+$2))
    return $total
}

sum 10 14
result=$?   // The result will the last execution result which is 10 + 14

