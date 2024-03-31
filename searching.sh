#!/bin/bash
# Task 2 - Question 1
# searching <permissions_octal> <days>

# Assigning the two parameters to variables with appropriate names.
no_of_days=$2
perm_octal=$1
answer=y # The user's answer is initially "y" (from yes) to ensure that the loop runs at least once.
# Initializing the variable sum to 0 outside the loop to calculate the total number of found files iteratively (classic algorithm).
sum=0
while [ "$answer" != "n" ]; do # As long as the answer is not "n", the command in the braces will return 0, and the commands in the while loop will be repeated.
    echo "Enter name of directory:"
    read dirName
    Nof1=$(find $dirName -type f -perm $perm_octal -ls | wc -l) # Number of files for the first list/subquery.
    echo "$Nof1 Regular files have permissions $perm_octal"
    find $dirName -type f -perm $perm_octal -ls
    echo $'\n' # Displays a newline for better readability of the lists.
    Nof2=$(find $dirName -type f -mtime $no_of_days -ls | wc -l) # Number of files for the second list/subquery.
    echo "$Nof2 Regular files that have been modified the last $no_of_days days"
    find $dirName -type f -mtime $no_of_days -ls
    echo $'\n'
    Nof3=$(find $dirName -type d -atime $no_of_days -ls | wc -l) # Number of files for the third list/subquery.
    echo "$Nof3 Subdirectories that have been accessed the last $no_of_days days"
    find $dirName -type d -atime $no_of_days -ls
    echo $'\n'
    Nod1=$(ls -l $dirName | grep "^-r..r..r.." | wc -l) # Number of files for the fourth list/subquery.
    echo "$Nod1 Regular files that everyone has read permission"
    ls -l $dirName | grep "^-r..r..r.."
    echo $'\n'
    Nod2=$(ls -l $dirName | grep "^d.wx.wx.wx" | wc -l) # Number of directories for the fifth list/subquery.
    echo "$Nod2 Directories that everyone can change (rename/create/delete files)"
    ls -l $dirName | grep "^d.wx.wx.wx"
    echo $'\n'
    sum=$((sum+(Nof1+Nof2+Nof3+Nod1+Nod2))) # Adds all counts and then adds them to the previous value of the sum variable.
    echo "Do you want to continue? (y/n): "
    read answer
    if [ "$answer" != "y" ]; then # If the user presses anything other than "y", the program terminates, displaying the content of sum.
        echo "Number of files/directories found: $sum"
        echo "Bye"
    fi
done
exit 0
