#!/usr/bin/python3
import requests
from requests.auth import HTTPBasicAuth
import subprocess

url = 'https://url.domain.here'
r = requests.get(url, auth=HTTPBasicAuth('etcduser', 'bl0cked4u'))
for item in r.json():
  outstr = "fail2ban-client set sshd banip {0}".format(item)
  p = subprocess.Popen(outstr, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  for line in p.stdout.readlines():
    print(line)
  retval = p.wait()
