import requests
import requests
import argparse
import sys
import subprocess
import time

parser = argparse.ArgumentParser()

parser.add_argument('--ip', type=str, help='IP address')
parser.add_argument('--db_port', type=str, help='PORT of the API')
args = parser.parse_args()

time.sleep(10)





success=False
db_container_state=True

try:
    while ((not success) and db_container_state):
        state = subprocess.check_output("""docker container inspect -f '{{.State.Running}}' db""", shell=True)

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