#!/bin/sh

while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
        v="${1/--/}"
        declare "$v"="$2"
        shift
    fi
    shift
done

# Login to Azure CR
sudo docker login -u cheese-customer-test -p $password themamaai.azurecr.io

# Pull the CHEESE app images

sudo docker pull themamaai.azurecr.io/cheese/cheese-ui:$customer
sudo docker pull themamaai.azurecr.io/cheese/cheese-database:$customer
sudo docker pull themamaai.azurecr.io/cheese/cheese-api:$customer
sudo docker pull themamaai.azurecr.io/cheese/cheese-docs:$customer
