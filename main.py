from json import load
from subprocess import run
from requests import get
import os
from prompt import selection


def zypp(install=None, remove=None, pkg_list=None, pkg=None):
    install_cmd = [
        "sudo",
        "zypper",
        "--non-interactive",
        "--no-gpg-checks",
        "install",
        "--auto-agree-with-licenses",
        "--no-recommends",
    ]
    remove_cmd = ["sudo", "zypper", "rm", "--no-confirm"]

    if install and pkg_list:
        for package in app_list[pkg_list]:
            check_cmd = f"rpm -qa | grep {package}"
            pkg = package
            is_available = run(check_cmd, capture_output=True, shell=True)
            if is_available.returncode == 0:
                print(package, "is already installed")
            else:
                print("Installing", package)
                install_cmd.append(package)
                run(install_cmd, capture_output=True)

    elif install and pkg:
        check_cmd = f"rpm -qa | grep {pkg}"
        is_available = run(check_cmd, capture_output=True, shell=True)
        print(is_available.returncode)
        if is_available.returncode == 0:
            print(pkg, "is already installed")
        else:
            print("Installing", pkg)
            install_cmd.append(pkg)
            run(install_cmd, capture_output=True)

    elif remove and pkg_list:
        for package in app_list[pkg_list]:
            check_cmd = f"rpm -qa | grep {package}"
            pkg = package
            is_available = run(check_cmd, capture_output=True, shell=True)
            if is_available.returncode == 0:
                print(package, "is found")
                remove_cmd.append(package)
                run(remove_cmd, capture_output=True)
            else:
                print(package, "not found")

    elif remove and pkg:
        check_cmd = f"rpm -qa | grep {pkg}"
        is_available = run(check_cmd, capture_output=True, shell=True)
        print(is_available.returncode)
        if is_available.returncode == 0:
            remove_cmd.append(pkg)
            print(pkg, "is found")
            run(remove_cmd, capture_output=True)
        else:
            print(pkg, "not found")


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
        zypp(install=True, pkg_list=i)

# Install common packages
options = ["multimedia", "utilities", "user"]
for i in options:
    zypp(install=True, pkg_list=i)

# Removes all the packages under remove-list in packages.json
# It's to be used to remove unneeded packages
# Or packages creating conflicts
zypp(remove=True, pkg_list="remove-list")
