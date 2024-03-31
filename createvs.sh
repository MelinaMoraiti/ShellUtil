#!/bin/bash
# Question 2
# createvs <directory> <number1> <number2> <username>

script=$0

if [ $# -ne 4 ]; then
    echo "$script: Incorrect number of parameters. Usage: $script <directory> <number1> <number2> <username>"
    exit 1
fi

ROOTFOLDER=$1
no_of_DBFOLDERS=$2
no_of_DATAFOLDERS=$3
USERNAME=$4

if [ ! -d $ROOTFOLDER ]; then
    echo "$script: Directory must be provided."
    exit 2
else
    cd $ROOTFOLDER
fi

# In the /etc/passwd file, all registered users who have access to the system are recorded.
# The file contains information for each user on each line, separated into fields by ":".
# Specifically, the username, which is unique, is in the first field.
# Using grep, I check if the USERNAME variable, which is the fourth parameter, indeed contains a user.
# With piping to wc -l, I count these lines, which will either be one or none.
user_exists=$(cat /etc/passwd | grep "^$USERNAME:" | wc -l)

if [ $user_exists -eq 0 ]; then
    echo "$script: Username must be provided as the fourth parameter."
    exit 3
fi

for ((i=1; i<=$no_of_DBFOLDERS; i++)); do
    if [ ! -d "dbfolder$i" ]; then
        mkdir "dbfolder$i"
        chown $USERNAME "dbfolder$i"
    else
        # If "dbfolder$i" already exists, an iteration will have been performed without creating any folders,
        # so whenever the code goes to the else part, the number of iterations needs to be increased to create as many folders as the user specified.
        ((no_of_DBFOLDERS++))
    fi
done

# Similar to "dbfolders"
for ((i=1; i<=$no_of_DATAFOLDERS; i++)); do
    if [ ! -d "datafolder$i" ]; then
        mkdir "datafolder$i"
        chown $USERNAME "datafolder$i"
    else
        ((no_of_DATAFOLDERS++))
    fi
done

exit 0
