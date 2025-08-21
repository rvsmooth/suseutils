from json import load
from subprocess import run
from requests import get
from os import path
from prompt import selection


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
            cmd_list = cmd[:]
            cmd_list.append(i)
            echo = ["echo", "installing", i]
            run(echo)
            run(cmd_list)
    elif pkg:
        cmd_pkg = cmd[:]
        cmd_pkg.append(pkg)
        echo = ["echo", "installing", pkg]
        run(echo)
        run(cmd_pkg)


def zypprm(pkg):
    cmd = ["rpm", "-qa", "|", pkg]
    package = run(cmd)
    if package:
        cmd_rm = ["sudo", "zypper", "--non-interactive", "remove", pkg]
        echo = ["echo", "removing", pkg]
        run(echo)
        run(cmd_rm)
    else:
        run(["echo", pkg, "is not installed!!"])


def get_pkgs():
    x = get(
        "https://raw.githubusercontent.com/rvsmooth/suseutils/refs/heads/main/packages.json"
    )

    with open(r"/tmp/packages.json", "w") as file_object:
        print(x.text, file=file_object)


if path.exists("/tmp/packages.json"):
    with open("/tmp/packages.json", "r") as applist:
        app_list = load(applist)
else:
    get_pkgs()

# install chosen WMs
# exit if none is chosen
#
if selection:
    for i in selection:
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
