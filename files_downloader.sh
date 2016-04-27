#!/bin/sh
display_usage() {
        echo "This script must be run with super-user privileges."
        echo -e "\nUsage:\n$0 [url] [file_format] \n"
        }

if [[ ( $# == "--help") ||  $# == "-h" ]]
        then
                display_usage
                exit 0
        fi
if [  $# -le 1 ]
        then
                display_usage
                exit 1
        fi
NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
NEW_UUID_FOLDER=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo "/tmp/$NEW_UUID"
wget -q -O - "$@" $1  |  sed -ne 's/.*\(http[^"]*\).*/\1/p' | grep $2 >> /tmp/$NEW_UUID
#cat /tmp/$NEW_UUID
mkdir /tmp/$NEW_UUID_FOLDER
cd /tmp/$NEW_UUID_FOLDER
for i in $( cat /tmp/$NEW_UUID ); do wget $i; done
echo "The files are saved here /tmp/$NEW_UUID_FOLDER"
