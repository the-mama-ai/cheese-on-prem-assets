#!/bin/bash
config_file=$1


# Define a function to export environment variables from a file
export_env_vars() {
    local file="$1"

    # Check if the file exists and is readable
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' not found or is not a regular file."
    fi

    # Read each line from the file
    while IFS= read -r line; do
        export $line
        # You can process each line as needed here
        # For example, you could add further processing logic
    done < "$file"

    FULL_IMAGE_NAME=themamaai.azurecr.io/cheese/cheese_inference:$CHEESE_CUSTOMER
    export INFERENCE_IMAGE=${FULL_IMAGE_NAME}

    FULL_IMAGE_NAME=themamaai.azurecr.io/cheese/cheese-database:$CHEESE_CUSTOMER
    export DB_IMAGE=${FULL_IMAGE_NAME}

    FULL_IMAGE_NAME=themamaai.azurecr.io/cheese/cheese-api:$CHEESE_CUSTOMER
    API_IMAGE=${FULL_IMAGE_NAME};

    FULL_IMAGE_NAME=themamaai.azurecr.io/cheese/cheese-ui:$CHEESE_CUSTOMER
    export UI_IMAGE=${FULL_IMAGE_NAME};

    FULL_IMAGE_NAME=themamaai.azurecr.io/cheese/cheese-docs:$CHEESE_CUSTOMER
    export DOCS_IMAGE=${FULL_IMAGE_NAME};


}


if [ "$config_file" = "" ]; then

export_env_vars /etc/cheese/cheese-env.conf

else

export_env_vars $config_file

fi


if groups | grep -q " sudo "; then
    :;
    
else
    if [ -f "$HOME/.config/cheese/cheese-env-user.conf" ]; then
        echo "Non sudo !!"
        export_env_vars $HOME/.config/cheese/cheese-env-user.conf;

    fi

fi
