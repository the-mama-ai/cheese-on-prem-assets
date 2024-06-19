#!/bin/bash

while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
        v="${1/--/}"
        declare "$v"="$2"
        shift
    fi
    shift
done

echo Installing CHEESE...
# Modify as needed !
db_port=9001
api_port=9002
ui_port=9003

# Define global environment variables

echo "export CHEESE_CUSTOMER=${customer}" >> ~/.bashrc 
echo "export CHEESE_PASSWORD=${password}" >> ~/.bashrc 
echo "export REPO_NAME='themamaai.azurecr.io/cheese'" >> ~/.bashrc 
echo "export LICENSE_FILE='/data/cheese_license_file.json'" >> ~/.bashrc 
echo "export CONFIG_FILE='/data/cheese_config_file.yaml'" >> ~/.bashrc 
echo "export ASSETS_FOLDER='${HOME}/cheese-on-prem-assets/assets'" >> ~/.bashrc 
echo "export LICENSING='True'" >> ~/.bashrc 
echo "export IP=${ip}" >> ~/.bashrc 
echo "export DB_PORT=${db_port}" >> ~/.bashrc 
echo "export API_PORT=${api_port}" >> ~/.bashrc 
echo "export UI_PORT=${ui_port}" >> ~/.bashrc 

FULL_IMAGE_NAME=$REPO_NAME"/cheese_inference:"$customer
echo "export INFERENCE_IMAGE=${FULL_IMAGE_NAME}" >> ~/.bashrc 

FULL_IMAGE_NAME=$REPO_NAME"/cheese-database:"$customer
echo "export DB_IMAGE=${FULL_IMAGE_NAME}" >> ~/.bashrc 

FULL_IMAGE_NAME=$REPO_NAME"/cheese-api:"$customer
echo "export API_IMAGE=${FULL_IMAGE_NAME}" >> ~/.bashrc 

FULL_IMAGE_NAME=$REPO_NAME"/cheese-ui:"$customer
echo "export UI_IMAGE=${FULL_IMAGE_NAME}" >> ~/.bashrc 

FULL_IMAGE_NAME=$REPO_NAME"/cheese-docs:"$customer
echo "export DOCS_IMAGE=${FULL_IMAGE_NAME}" >> ~/.bashrc 

source ~/.bashrc
sudo cp cheese /usr/local/bin
sudo chmod +x /usr/local/bin/cheese

sudo cp cheese-inference /usr/local/bin
sudo chmod +x /usr/local/bin/cheese-inference

sudo cp cheese-embeddings /usr/local/bin
sudo chmod +x /usr/local/bin/cheese-embeddings

sudo cp cheese-app /usr/local/bin
sudo chmod +x /usr/local/bin/cheese-app

sudo cp update-cheese /usr/local/bin
sudo chmod +x /usr/local/bin/update-cheese


update-cheese