#!/usr/bin/env bash

SDDM_CLONE_DIR='/tmp/simplicity'
SDDM_THEME_DIR='/usr/share/sddm/themes/simplicity/'

source utils.sh

PYELL Setting up display manager.

if [[ -d "$SDDM_THEME_DIR" ]]; then

	PYELL sddm-astronaut-theme is already installed

else

	PYELL Installing SDDM...
	__zypper_install sddm 
	PDONE
	PYELL Configuring SDDM...
	sudo git clone https://gitlab.com/dotsmooth/sddm-simplicity-theme "$SDDM_CLONE_DIR"
	sudo mv "$SDDM_CLONE_DIR"/simplicity "$SDDM_THEME_DIR"

	echo "[Theme]
	Current=simplicity" | sudo tee /etc/sddm.conf

	PDONE
fi

PYELL Enabling SDDM
sudo systemctl enable sddm
PDONE

PYELL Set sddm as the default display manager 
sudo systemctl set-default graphical.target
sudo update-alternatives --set default-displaymanager /usr/lib/X11/displaymanagers/sddm
PDONE
