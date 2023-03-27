MORE LINUX COMMANDS

1. Piping (take output from another to be input in another)
    : cat log.txt | less
        enter space key to => next page
        enter b key to <== previous page
        enter q key to quit the program
    : history | less 
        to see all the cmd history

2. filtering using grep
   : history | grep sudo   (grab all cmd that has sudo in it)
   : history | grep sudo | less

3. filtering using grep with multiple words
   : history | grep "sudo chmod"
   : history | grep "sudo chmod" | less

4. filtering using grep with directory list
   : ls /usr/bin | grep zip
   : ls /usr/bin | grep python

5. redirect a content into another file with > key
   : history | grep sudo > sudo-commands.txt

6. redirect a content of a file into another new file using >
   : cat sudo-commands.txt > sudo-rm-commands.txt

7. redirect a content of a file into another existing file using >>
   : history | grep chmod  >> sudo-rm-commands.txt

8. different command at the same time 
   : clear; sleep 10; echo "Hello big man!"
   it ll clear the console, wait for 10 sec and echo the text

9. 