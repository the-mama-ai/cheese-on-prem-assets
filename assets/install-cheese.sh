#!/bin/bash

env_file=$1

while [ $# -gt 0 ]; do
    if [[ $1 == --* ]]; then
        v=${1/--/}
        declare $v=$2
        shift
    fi
    shift
done


echo Installing CHEESE...

# Define Env variables

echo "Setting Env vars..."
source cheese-env.sh --template True

echo "Setting update scripts..."
sudo cp update-cheese /usr/local/bin
sudo chmod +x /usr/local/bin/update-cheese


echo "Setting environment scripts scripts..."
sudo mkdir /etc/cheese
sudo cp $ASSETS_FOLDER/cheese-env.sh /etc/cheese
sudo cp $ASSETS_FOLDER/check_database_server.py /etc/cheese


echo "Setting Environment configuration files..."

if [ ! "$env_file" = "" ]; then
    echo Setting from file $env_file
    sudo cat $env_file > /etc/cheese/cheese-env.conf;

else
    echo Please define an environment file

fi

echo "Setting permissions"

sudo chmod -R 777 /etc/cheese
sudo chmod 774 /etc/cheese/cheese-env.sh
sudo chmod 774 /etc/cheese/check_database_server.py
sudo chmod 774 /etc/cheese/cheese-env.conf

update-cheese
