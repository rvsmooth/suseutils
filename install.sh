#!/bin/bash

# source colors script
source utils.sh

#
# execution
#

sudo zypper refresh
sudo zypper --non-interactive update

PYELL Preparing environment for upcoming transactions
__zypper_install curl git unzip wget zip opi
PDONE

source 01-multimedia.sh
source 02-twm.sh
source 03-user_pkgs.sh
source 04-utilities.sh
source 05-ddcutil.sh
source 06-displaymanager.sh
source 07-dots.sh
source 08-nerdfonts.sh
source 09-theme-setup.sh
