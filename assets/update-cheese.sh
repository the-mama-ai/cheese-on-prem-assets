#!/bin/sh
# Login to Azure CR
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

echo updating CHEESE...
sudo docker login -u cheese-customer-test -p $CHEESE_PASSWORD $REPO_NAME

# # Pull the CHEESE app images

sudo docker pull $UI_IMAGE
sudo docker pull $DB_IMAGE
sudo docker pull $API_IMAGE
sudo docker pull $DOCS_IMAGE
sudo docker pull $INFERENCE_IMAGE

