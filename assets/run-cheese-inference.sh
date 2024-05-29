#!/bin/sh
while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
        v="${1/--/}"
        declare "$v"="$2"
        shift
    fi
    shift
done

./pull-inference-image.sh --password $password

LICENSING="True"


EXTENSION=".csv"
DELIMITER=","
INDEX_TYPE=$index_type   # in_memory or clustered
DEVICE="cuda"
BATCH_SIZE=128

TEST_FILES_DIR=/home/ubuntu/cheese
DEST_DIR="/data"
OUTPUT_DIRECTORY=$DEST_DIR"/output"

IMAGE_TAG="themamaai.azurecr.io/cheese/cheese_inference"
INPUT_FILE=$DEST_DIR"/"$input_file
GPU_DEVICE_ID=0
CHUNK_SIZE=100000  # Chunk size for embeddings computation

echo "Making output dir..."
sudo mkdir /home/ubuntu/cheese/output

echo "Running CHEESE inference..."
sudo docker run -u root -v $TEST_FILES_DIR:/data -it CHEESE_LICENSE_FILE=$DEST_DIR"/"$license_file --env LICENSING=$LICENSING --gpus all --rm $IMAGE_TAG --index_type $INDEX_TYPE --input_file $INPUT_FILE --extension $EXTENSION --delimiter $DELIMITER --output_directory $OUTPUT_DIRECTORY --gpu_device_id $GPU_DEVICE_ID --batch_size $BATCH_SIZE --chunk_size $CHUNK_SIZE
