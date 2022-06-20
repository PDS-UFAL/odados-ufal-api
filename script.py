import requests
import sys

api_url = sys.argv[1]
admin_token = sys.argv[2]

url = api_url + "/forms"
headers = {"Authorization": "Bearer " + admin_token}

get_response = requests.get(url=url, headers=headers)
data = get_response.json()

for d in data['forms']:
    del_url = url + "/" + str(d["id"])
    requests.delete(url=del_url, headers=headers)
    print("ok")
