import json
import subprocess

with open("packages.json", "r") as applist:
    app_list = json.load(applist)

def zyppstall(pkglist):
    for i in app_list[pkglist]:
        cmd = ["sudo", "zypper", "--non-interactive", "--no-gpg-checks", "install",
                "--auto-agree-with-licenses", "--no-recommends", i ]
        echo = ["echo", "installing", i]
        subprocess.run(echo)
        subprocess.run(cmd)

from prompt import results

if results:
    for i in results:
        zyppstall(i)

zyppstall("multimedia")
zyppstall("utilities")
zyppstall("user")
