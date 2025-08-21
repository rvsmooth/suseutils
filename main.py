import json
import subprocess
import requests
import os
from prompt import results


def zyppstall(pkglist=None, pkg=None):
    cmd = [
        "sudo",
        "zypper",
        "--non-interactive",
        "--no-gpg-checks",
        "install",
        "--auto-agree-with-licenses",
        "--no-recommends",
    ]
    if pkglist:
        for i in app_list[pkglist]:
            cmdf = cmd[:]
            cmdf.append(i)
            echo = ["echo", "installing", i]
            subprocess.run(echo)
            subprocess.run(cmdf)
    elif pkg:
        cmdn = cmd[:]
        cmdn.append(pkg)
        echo = ["echo", "installing", pkg]
        subprocess.run(echo)
        subprocess.run(cmdn)


def zypprm(pkg):
    cmd_1 = ["rpm", "-qa", "|", pkg]
    package = subprocess.run(cmd_1)
    if package:
        cmd = ["sudo", "zypper", "--non-interactive", "remove", pkg]
        echo = ["echo", "removing", pkg]
        subprocess.run(echo)
        subprocess.run(cmd)
    else:
        subprocess.run(["echo", pkg, "is not installed!!"])


def get_pkgs():
    x = requests.get(
        "https://raw.githubusercontent.com/rvsmooth/suseutils/refs/heads/main/packages.json"
    )

    with open(r"/tmp/packages.json", "w") as file_object:
        print(x.text, file=file_object)


if os.path.exists("/tmp/packages.json"):
    with open("/tmp/packages.json", "r") as applist:
        app_list = json.load(applist)
else:
    get_pkgs()

# install chosen WMs
# exit if none is chosen
#
if results:
    for i in results:
        zyppstall(i)

# Fix for fish shell
# busybox-gzip conflicts with dependencies of fish
zypprm("busybox-gzip")

## Fix for installation of man
## remove conflicting packages
zypprm("mandoc")
zypprm("busybox-less")

# Install common packages
zyppstall("multimedia")
zyppstall("utilities")
zyppstall("user")
