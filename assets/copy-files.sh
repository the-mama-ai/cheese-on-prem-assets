# !bin/sh
INSTANCE_IP="X.X.X.X"
ASSETS_DIR=""
INPUT_FILE=""
PRIVATE_KEY=""
scp -i $PRIVATE_KEY $INPUT_FILE ubuntu@$INSTANCE_IP:/home/ubuntu/cheese
scp -i $PRIVATE_KEY -r $ASSETS_DIR ubuntu@$INSTANCE_IP:/home/ubuntu/cheese