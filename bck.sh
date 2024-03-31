#!/bin/bash
#
# Task 2 - Question 4
# bck <username> <file1> <file2>
# $0 [OWNER] [SOURCE] [DEST]
#

if [ $# -ne 3 ]; then # Classic check for the total number of parameters
  echo "$0 creates backup of a user from a source directory/file to a destination directory/file"
  echo "Usage: $0 [OWNER] [SOURCE] [DEST]"
  exit 1
fi

# Creating variables with the names of the parameters
username=$1
src_data=$2
dest_backup=$3

# The .tar extension in the destination backup directory is needed for the tar command
archive_file="$dest_backup.tar"
user_exists=$(cat /etc/passwd | grep $username | wc -l) # Checking if the username (1st parameter) exists in the system.

if [ $user_exists -eq 0 ]; then
 echo "User $username does not exist. Exiting with 1..."
fi

if [ ! -e $src_data -o ! -e $dest_backup ]; then
 echo "$0 needs a source and a destination directory/file. Exiting with 1..."
 exit 1
else
 if [ -f $dest_backup ]; then
  tar -rvf "$dest_backup/$archive_file" "/home/$username/$src_data"
 else
  tar -cvf "$dest_backup/$archive_file" "/home/$username/$src_data"
 fi
fi
tar -tvf $archive_file
exit 0
