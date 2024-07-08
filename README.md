# cheese-on-prem-assets

This is a public repository for installing the CHEESE on-premises version.

### Requirements

- Ubuntu

- Docker.

### How to install CHEESE?


You can install CHEESE on your instance using the following steps :

1. Clone this repository on your instance

2. Copy the template environment configuration file in `config/cheese-env.conf.template` which defines global environment variables, and modify it accordingly.

    - `CHEESE_CUSTOMER` : The customer name
    - `CHEESE_PASSWORD` : The password used to pull Docker images for running CHEESE
    - `LICENSE_FILE` : The CHEESE license file
    - `CONFIG_FILE` : A YAML configuration file for running the CHEESE tool on-premises which contains paths to the data, models... A template can be found in `config/cheese_config_file.yaml.template`
    - `IP` : The IP address of the instance
    - `DB_PORT` : The port on which to expose the CHEESE database server
    - `API_PORT` : The port on which to expose the CHEESE API
    - `UI_PORT` : The port on which to expose the CHEESE UI

3. Run `source install-cheese.sh --env_config <env_config_file>`. Where `<env_config_file>` is the path to your environment configuration file.

4. Test if the installation is working by running the command `cheese`
