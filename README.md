# ShellUtil
This repository contains a collection of shell scripts developed as part of my coursework during an Operating Systems course in the 3rd semester. These scripts automate various system tasks such as backups, process management, directory comparison, and file searching. Simplify your system administration tasks with these handy shell utilities! 🛠️

## Scripts Overview

1. **searching**: A script designed to search for files within a directory based on specific permissions and modification dates. It provides a flexible way to locate files matching certain criteria within a directory structure.
2. **bck**: This script facilitates the creation of backups for user files from a source directory to a destination directory. It ensures the existence of both directories and creates a backup archive using the tar command.
3. **cmpdir**: This script compares the contents of two directories, identifying files unique to each directory and common files between them. It utilizes the diff command to generate differences and provides detailed output regarding file presence and sizes.
4. **bck1**: An enhanced version of the backup script, which introduces a parameter for specifying the backup time. It schedules the backup operation using the at command, allowing users to schedule backups for specific times.
5. **mfproc**: Displays information about processes with options to filter by username and state.
   
## Prerequisites
- Bash shell
- Linux or Unix-like operating system

## Usage
1. Clone the repository to your local machine.
```bash
git clone https://github.com/MelinaMoraiti/ShellUtil.git
```
3. Run each script from the command line by providing appropriate parameters as specified in the usage instructions within each script file.

## Example
To run the **bck** script:
```bash
./bck [OWNER] [SOURCE] [DEST] [TIME]
```
