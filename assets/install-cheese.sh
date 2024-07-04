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


echo "Setting Environment configuration files..."

if [ ! "$env_file" = "" ]; then
    echo Setting from file $env_file
    sudo cat $env_file > /etc/cheese/cheese-env.conf;

else
    echo "It is recommended that you supply an environment configuration file. Setting environment from template"
    sudo cat cheese-env.conf.template > /etc/cheese/cheese-env.conf;
    

fi

source cheese-env.sh

echo "Setting update scripts..."
sudo cp update-cheese /usr/local/bin
sudo chmod +x /usr/local/bin/update-cheese


echo "Setting cheese scripts..."
sudo mkdir /etc/cheese
sudo cp cheese-env.sh /etc/cheese
sudo cp check_database_server.py /etc/cheese

echo "Setting permissions"

sudo chmod -R 777 /etc/cheese
sudo chmod 774 /etc/cheese/cheese-env.sh
sudo chmod 774 /etc/cheese/check_database_server.py
sudo chmod 774 /etc/cheese/cheese-env.conf

update-cheese
