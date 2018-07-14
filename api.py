#!/usr/bin/python3.6
from flask import Flask, request
from flask_restful import Resource, Api
import requests

app = Flask(__name__)
api = Api(app)
get_url = "http://127.0.0.1:2379/v2/keys/fail2ban/SSH?recursive=true"
put_url = "http://127.0.0.1:2379/v2/keys/fail2ban/SSH/"
 
class GrabRecords(Resource):
  def get(self):
    blacklist = []
    r = requests.get(get_url)
    if r.status_code == 200:
      records = r.json()["node"]["nodes"]
      for item in records:
        ip = str(item["key"]).rsplit('/', 1)[1]
        blacklist.append(ip) 
    return(blacklist)

class UpdateRecords(Resource):
  def put(self, ip):
    r = requests.put(put_url + ip, data = {'value': 5})
    return("Added")
  def delete(self,ip):
    r = requests.delete(put_url + ip)
    return("Deleted")

api.add_resource(GrabRecords, '/blacklist')
api.add_resource(UpdateRecords, '/blacklist/<ip>')


if __name__ == '__main__':
  app.run(debug=False)
