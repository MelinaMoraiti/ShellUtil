#!/bin/bash
# $0 [OWNER] [SOURCE] [DEST] [TIME]
# Task 2 - Question 4 - Subquestion 1
# bck1 <username> <file1> <file2> <time>

if [ $# -ne 4 ]; then # Classic check for the total number of parameters
  echo "$0 creates backup of a user from a source directory/file to a destination directory/file"
  echo "Usage: $0 [OWNER] [SOURCE] [DEST] [TIME]"
  exit 1
fi

# Creating variables with the names of the parameters
username=$1
src_data=$2
dest_backup=$3
backup_time=$4

# The .tar extension in the destination backup directory is needed for the tar command
archive_file="$dest_backup.tar"
user_exists=$(cat /etc/passwd | grep $username | wc -l)

if [ $user_exists -eq 0 ]; then
 echo "User $username does not exist. Exiting with 1..."
fi

if [ ! -e $src_data -o ! -e $dest_backup ]; then
 echo "$0 needs a source and a destination directory/file. Exiting with 1..."
 exit 1
else
# Piping and using 'at' to execute the corresponding tar at the time specified by the user as the fourth parameter
 if [ -f $dest_backup ]; then
  tar -rvf "$dest_backup/$archive_file" "/home/$username/$src_data" | at $backup_time 
 else
  tar -cvf "$dest_backup/$archive_file" "/home/$username/$src_data" | at $backup_time
 fi
fi
tar -tvf $archive_file
exit 0
