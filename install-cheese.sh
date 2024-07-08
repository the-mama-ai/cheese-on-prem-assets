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

echo "Setting Environment configuration files..."

if [ ! "$env_config" = "" ]; then
    echo Setting from file $env_config
    sudo cat $env_config > /etc/cheese/cheese-env.conf;

else
    exit "Please specify an environment configuration file. Please modify the template in config/cheese-env.conf.template"    

fi

source cheese-env.sh

echo "Setting update scripts..."
sudo cp scripts/update-cheese /usr/local/bin
sudo chmod +x /usr/local/bin/update-cheese


echo "Setting cheese scripts..."
sudo mkdir /etc/cheese
sudo cp cheese-env.sh /etc/cheese
sudo cp assets/check_database_server.py /etc/cheese

echo "Setting permissions"

sudo chmod -R 777 /etc/cheese
sudo chmod 774 /etc/cheese/cheese-env.sh
sudo chmod 774 /etc/cheese/check_database_server.py
sudo chmod 774 /etc/cheese/cheese-env.conf

update-cheese --install True
