import requests
import requests
import argparse
import sys
import subprocess
import time

parser = argparse.ArgumentParser()

parser.add_argument('--ip', type=str, help='IP address')
parser.add_argument('--db_port', type=str, help='PORT of the API')
parser.add_argument('--user', type=str, help='The user')
args = parser.parse_args()





success=False
db_container_state=True

docker_state_flag='{{.State.Running}}'


try:
    while ((not success) and db_container_state):
        try:
            state=subprocess.check_output(f"""docker container inspect -f {docker_state_flag} {args.user}_db""", shell=True)
        except subprocess.CalledProcessError as e:
            print("Database server is down !!!")
            sys.exit(0)


        db_container_state = state.decode("utf-8").strip()=="true"
        try:
            resp=requests.get(f'http://{args.ip}:{args.db_port}/available_dbs',{},verify=False).json()
            success=True
            print("Connected to database server !")
        except:
            if not db_container_state:
                print("Database server is down !!!")
                sys.exit(0)
            continue

except KeyboardInterrupt:
    sys.exit(0)