#!/bin/bash
#
# Task 2 - Question 3
# cmpdir <directory1> <directory2> <directory3>
#

if [ $# -ne 3 ]; then
 echo "$0: Incorrect number of parameters. Usage: $0 <directory1> <directory2> <directory3>"
 exit 1
fi

if [ ! -d $1 -o ! -d $2 -o ! -d $3 ]; then
 echo "$0: Directory parameters are required."
 exit 2
fi

# Using the diff command within backticks with piping to grep and wc -l. The aim is to show how many files are present
# in one directory compared to another.
echo "`diff $1 $2 | grep "Only in $1:" | wc -l` file/files are not present in directory $2"

# Using the cut command to extract the fourth field from the lines found by grep, which contains the filenames. The fields are separated by " ".
FilesOnlyInDir1=$(diff $1 $2 | grep "Only in $1:" | cut -d" " -f4)

# Changing directory to $1 because the variable FilesOnlyInDir1 doesn't contain the absolute paths of the files, and the subsequent ls command would fail.
cd $1
ls -s $FilesOnlyInDir1
cd "../" 

echo $'\n'

# Same process as for directory $1, just this time for directory $2.
echo "`diff $1 $2 | grep "Only in $2:" | wc -l` file/files are not present in directory $1"
FilesOnlyInDir2=$(diff $1 $2 | grep "Only in $2:" | cut -d" " -f4)
cd $2
ls -s $FilesOnlyInDir2
echo $'\n'
cd "../"

# Using diff with the -y parameter to show common files between the two directories. Lines starting with "diff -y" 
# contain the absolute paths of the common files in the third and fourth fields separated by " ".
CommonFiles=$(diff -y "$1" "$2" | grep "diff -y" | cut -d" " -f3,4)
no_of_comm_files=$(diff -y $1 $2 | grep "diff -y" | wc -l)  # Number of common files.

echo "$no_of_comm_files Common file/files in directories $1 and $2:"
if [ $no_of_comm_files -ne 0 ]; then
 ls -s $CommonFiles
 mv -f $CommonFiles "$3" 
# The mv command will move the common files from directories $1 and $2 to directory $3, but because the files from $2 are the same as those from $1, the command will fail to overwrite them in $3.
 rm $CommonFiles
 for i in $CommonFiles; do
  filename=$(echo $i | cut -d"/" -f2) 
# Checking if the files that have already been moved to the third directory are regular files and not directories, as ln cannot create hard links for entire directories.
  if [ -f "$3/$filename" ]; then
    ln "$3/$filename" "$1/$filename""_LINK"  # The links will have a name based on the name of each file followed by "_LINK" to differentiate them.
    ln "$3/$filename" "$2/$filename""_LINK"
  fi
 done
fi
exit 0
