import requests
import requests
import argparse
import sys
parser = argparse.ArgumentParser()

parser.add_argument('--ip', type=str, help='IP address')
parser.add_argument('--db_port', type=str, help='PORT of the API')
args = parser.parse_args()



success=False

try:
    while not success:
        try:
            resp=requests.get(f'http://{args.ip}:{args.db_port}/available_dbs',{},verify=False).json()
            success=True
            print("Connected to database server !")
        except:
            continue

except KeyboardInterrupt:
    sys.exit(0)