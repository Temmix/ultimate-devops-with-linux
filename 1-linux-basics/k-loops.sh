 #!/bin/bash

echo "--------- LOOPING ALLL PARAMS ----------------"

echo "all parameters $*"

# For loop
for param in $*
    do 
        if [ -d "$param" ]
            then 
                echo "Executing scripts in the config folder"
                ls -l "$param"
        fi 
        echo $param 
    done

# while loop
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

# run the script by running bash j.loops.sh temi admins config.yaml index.html parents