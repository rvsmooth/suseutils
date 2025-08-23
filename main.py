from json import load
from subprocess import run
from requests import get
import os
from prompt import selection


def zyppstall(pkglist=None, pkg=None):
    """
    A function to utilize zypper to perform installations
    on lists and standalone packages provided as arguments
    """
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
            print("Installing", i)
            x = run(cmd_list, capture_output=True, text=True)
            with open(r"error_packages.txt", "a") as file_object:
                print(
                    x.stderr,
                    file=file_object,
                )
                if x.stderr:
                    print(i, "is not installed \n")

    elif pkg:
        cmd_pkg = cmd[:]
        cmd_pkg.append(pkg)
        print("Installing", pkg)
        x = run(cmd_pkg, capture_output=True, text=True)
        with open(r"error_packages.txt", "a") as file_object:
            print(x.stderr, file=file_object)
        if x.stderr:
            print(pkg, "is not installed \n")


def zypprm(pkglist=None, pkg=None):
    """
    A function to utilize zypper to perform deinstallations
    on lists and standalone packages provided as arguments
    """
    check_pkg = ["rpm", "-qa", "|"]
    rm_pkg = ["sudo", "zypper", "rm", "--no-confirm"]
    if pkglist:
        chk_cmd = check_pkg[:]
        for i in app_list[pkglist]:
            chk_cmd.append(i)
            is_available = run(chk_cmd, capture_output=True)
            if is_available:
                rm_pkg_cmd = rm_pkg[:]
                rm_pkg_cmd.append(i)
                run(rm_pkg_cmd)
    elif pkg:
        rm_pkg_cmd = rm_pkg[:]
        rm_pkg_cmd.append(pkg)
        run(rm_pkg_cmd, capture_output=True)


def get_pkgs(url):
    x = get(url)
    # Save the file that is read as /tmp/packages.json
    with open(r"/tmp/packages.json", "w") as file_object:
        print(x.text, file=file_object)


# Check for the existence of packages.json
# Download if it doesn't exist
if os.path.exists("/tmp/packages.json"):
    with open("/tmp/packages.json", "r") as applist:
        app_list = load(applist)
else:
    get_pkgs(
        "https://raw.githubusercontent.com/rvsmooth/suseutils/refs/heads/main/packages.json"
    )

# Install softwares based on the initial selection
# perfomed with a prompt
if selection:
    for i in selection:
        zyppstall(i)

# Install common packages
options = ["multimedia", "utilities", "user"]
for i in options:
    zyppstall(i)

# Removes all the packages under remove-list in packages.json
# It's to be used to remove unneeded packages
# Or packages creating conflicts
zypprm("remove-list")
