#!/bin/sh

while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
        v="${1/--/}"
        declare "$v"="$2"
        shift
    fi
    shift
done

CUSTOMER_NAME="Abbvie"

bash pull-app-images.sh --password $password --customer $CUSTOMER_NAME


# Make sure that the repos are pulled and up-to-date !!!
REPO_NAME="themamaai.azurecr.io/cheese"


LICENSE_FILE="/data/license_file.json"
LICENSING="True"
CONFIG_FILE="/data/config_file.yaml"

DB_PORT=9001
API_PORT=9002
UI_PORT=9003

# Run cheese-database
IMAGE_NAME="cheese-database"
FULL_IMAGE_NAME=$REPO_NAME"/"$IMAGE_NAME":"$CUSTOMER_NAME

echo "Running cheese database server..."
sudo docker run -d -v /data:/data -u root --env PORT=$DB_PORT --env CONFIG_FILE=$CONFIG_FILE --env LICENSING=$LICENSING --env CHEESE_LICENSE_FILE=$LICENSE_FILE --name db -p $DB_PORT:$DB_PORT --rm $FULL_IMAGE_NAME


sudo python3 -c "import time; time.sleep(60);"

echo "Running cheese UI .."
IMAGE_NAME="cheese-ui"
FULL_IMAGE_NAME=$REPO_NAME"/"$IMAGE_NAME":"$CUSTOMER_NAME
sudo docker run -d -u root --env CHEESE_API="http://"$ip":$API_PORT"  --name ui -p $UI_PORT:3000 --rm $FULL_IMAGE_NAME


# # # Run cheese-orchestrator
IMAGE_NAME="cheese-api"
FULL_IMAGE_NAME=$REPO_NAME"/"$IMAGE_NAME":"$CUSTOMER_NAME

echo "Running cheese API..."
sudo docker run -d -v /data:/data -it -u root --env PORT=$API_PORT --env CONFIG_FILE=$CONFIG_FILE --env LICENSING=$LICENSING --env CHEESE_LICENSE_FILE=$LICENSE_FILE --name api -p $API_PORT:$API_PORT --rm $FULL_IMAGE_NAME


# # # Run cheese-docs
IMAGE_NAME="cheese-docs"
FULL_IMAGE_NAME=$REPO_NAME"/"$IMAGE_NAME":"$CUSTOMER_NAME

echo "Running cheese DOCS..."
sudo docker run -d --name cheese_docs -p 9010:9010 --rm $FULL_IMAGE_NAME

API_FOR_DOCS="!!swagger-http http://"$ip":"$API_PORT"/openapi.json!!"

rm -f index.md
echo $API_FOR_DOCS > index.md
sudo docker cp index.md cheese_docs:/opt/themama.ai/docs
