#!/usr/bin/env bash 

source utils.sh 

packages=(
	"ddcutil"
	"i2c-tools"
)

PYELL Setting up ddcutil and i2c

__zypper_install "${packages[@]}"

if [ ! -f /etc/udev/rules.d/60-ddcutil-i2c.rules  ]; then 
	echo 'SUBSYSTEM=="i2c-dev", KERNEL=="i2c-[0-9]*", ATTRS{class}=="0x030000", TAG+="uaccess"
	SUBSYSTEM=="dri", KERNEL=="card[0-9]*", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/60-ddcutil-i2c.rules
else 
        PYELL udev rules are already present
	PYELL aborting operation
fi 

if [ ! -f /etc/modules-load.d/60-i2c.conf ]; then 
echo 'i2c_dev' | sudo tee /etc/modules-load.d/60-i2c.conf 
else 
	PYELL i2c_dev is already set to auto load 
	PYELL aborting operation

PDONE

