#!/bin/echo Warning: this file should be sourced

# create a directory, and switch to it
mkdir_cd()
{
    if [ ! $# -eq 1 ]; then
        echo "Please supply the name of the folder to create and cd into" >&2
        exit 1
    else
        mkdir "$1"
        cd "$1"
    fi
}


# function: backup_current_dir
# create a zip archive with all files and folders 
# ( including hidden ) from the current folder
backup_current_dir()
{
    if [ -f backup.zip ]; then
        rm backup.zip
    else
        find . | xargs zip -q -u backup
    fi
}


# looks for backup.zip archive. If found, 
# deletes all files in the current folder
# and unpacks the archive
restore_backup()
{

    if [ -f backup.zip ]; then
        find . \! \( -name backup.zip -or -name '.' \) | xargs rm -rf
        unzip -q backup.zip
        echo "deleted all existing files in the current dir and unzipped backup.zip"
    else
        echo "backup.zip was not found in this directory"
        return 1
    fi
}


# for the command prompt
# this funtion is run each time the user entered a simple command
simple_command_entered()
{
    echo 'you just enterd a simple command !'
}

# creates a file containing a list of all installed packages,
# sorted by date
list_installed_packages()
{
    echo -e "State     \tLast change \t \tName"\
        > PkgLog && ls -lsrt /var/lib/dpkg/info/*.list \
        | awk '{print $6"\t"$7"  "$8"\t"$9}'\
        | sed -e "s/\/var\/lib\/dpkg\/info\///"\
        -e "s/.list//" \
        -e "s/^0\t/Removed \t/" \
        -e "s/^[0-9]*\t/Installed\t/"\
        >> PkgLog
}

# Grep xampp config files.
# Treat argument as a regular expression
grep_xampp_cfg()
{
    grep --color='auto'\
            --line-number\
            --with-filename\
            --ignore-case\
            -B 3 -A 1 -e "$1"\
            /d/pdev/xampp/php/php.ini\
            /d/pdev/xampp/apache/conf/httpd.conf\
            /d/pdev/xampp/mysql/bin/my.ini
}

# from: http://stackoverflow.com/a/4767462
function findTextInAsciiFiles {
    # usage: findTextInAsciiFiles DIRECTORY NEEDLE_TEXT
    find "$1" -type f -exec grep -l "$2" {} \; -exec file {} \; | grep text | cut -d ':' -f1
}

# from: http://stackoverflow.com/a/4767462
function findAsciiFiles {
    # usage: findAsciiFiles DIRECTORY
    find "$1" -type f -exec file {} \; | grep text | cut -d ':' -f1
}	