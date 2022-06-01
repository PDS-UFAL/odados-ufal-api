import requests
import sys

api_url = sys.argv[1]
admin_token = sys.argv[2]

url = api_url + "/responses"
headers = {"Authorization": "Bearer " + admin_token}

get_response = requests.get(url=url, headers=headers)
data = get_response.json()

for d in data:
    if d["sector_id"] == None:
        put_url = url + "/" + str(d["id"])
        put_response = requests.put(url=put_url, headers=headers, json={
                                    "response": {"sector_id": d["user_sector"]}})
        put_data = put_response.json()
        print(put_data)
