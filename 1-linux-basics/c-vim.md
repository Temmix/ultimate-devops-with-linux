VIM COMMANDS

1. to open a file with vi or vim
    vim readMe.md

2. by default it will be read only mode, you can navigate with arrow keys
    left, right, up and down arrow key to navigate

3. to open a file with vim
    vim ReadMe.md

4. to edit a file with vim
   enter i: to change to insert mode
   enter esc: to change back to command mode

   enter :wq  : to save the changes
   enter :q!  : to discard the changes and quit

5. to delete a whole line in a text file
   in command mode, enter dd

6. to delete block of lines
   in command mode, enter d5d  (this will delete the next 5 lines from the cursor)

7. to undo your changes
   in command mode, enter u

8. jump to the begining of a line
   in cmd mode, enter 0

9. jump to the end of a line
    in cmd mode, enter $

10. jump to the end of a line and switch to insert mode
    in cmd mode, enter A

11. jump to any line within the file
    in cmd mode, 12G (this will jump to line 12 of the text file)

12. search for a text in the whole file
    enter: /searchTerm and press enter
    enter : n  (to jump to the next occurence )
    enter : N ( to jump to the previous occurence )

13. to search and replace a word 
    enter: %s/oldText/newText
    