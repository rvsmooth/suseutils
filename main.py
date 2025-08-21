import json
import subprocess
import requests
import os

def zyppstall(pkglist):
    for i in app_list[pkglist]:
        cmd = ["sudo", "zypper", "--non-interactive", "--no-gpg-checks", "install",
                "--auto-agree-with-licenses", "--no-recommends", i ]
        echo = ["echo", "installing", i]
        subprocess.run(echo)
        subprocess.run(cmd)

def get_pkgs():
    x = requests.get('https://raw.githubusercontent.com/rvsmooth/suseutils/refs/heads/main/packages.json')

    with open(r'/tmp/packages.json', 'w')as file_object:
        print(x.text, file=file_object)

if os.path.exists("/tmp/packages.json"):
    with open("/tmp/packages.json", "r") as applist:
        app_list = json.load(applist)
else:
    get_pkgs()

from prompt import results

if results:
    for i in results:
        zyppstall(i)

zyppstall("multimedia")
zyppstall("utilities")
zyppstall("user")
