#!/bin/bash

# some notes for me
## list values as an array
#echo "List values as an array"
#for cursor in ${cursors[@]}; do 
#	echo $cursor 
#done
#
#echo 
#
## list keys as an array
#echo "List keys as an array"
#for cursor in ${!cursors[@]}; do 
#	echo $cursor #cursor file 
#	echo ${cursors[$cursor]} # cursor dir 
#done
#
#
source utils.sh

WORK_DIR="/tmp/work"
SRC_URL="https://github.com/rvsmooth/wallpapers/releases/latest/download"
ICONS_DIR="$HOME/.icons"
THEMES_DIR="$HOME/.themes"
DIRS=(
	"/usr/share/themes"
	"$HOME/.local/share/themes"
	"$HOME/.themes"
	"/usr/share/icons"
	"$HOME/.local/share/icons"
	"$HOME/.icons"
)

declare -A cursors 
declare -A icons 
declare -A themes
cursors["Bibata-Modern-Ice.tar.xz"]="Bibata-Modern-Ice"
cursors["Bibata-Modern-Classic.tar.xz"]="Bibata-Modern-Classic"
icons["kora-1-7-1.tar.xz"]="kora kora-light kora-light-panel"
icons["papirus-icon-theme-20250201.tar.gz"]="Papirus Papirus-Dark Papirus-Light ePapirus ePapirus-Dark"
themes["Gruvbox-Dark-BL-MB.zip"]="Gruvbox-Dark Gruvbox-Dark-hdpi Gruvbox-dark-xhdpi"
themes["Tokyonight-Dark-BL-MB.zip"]="Tokyonight-Dark Tokyonight-Dark-hdpi Tokyonight-Dark-xhdpi"

function download_asset(){
	if [ -e $WORK_DIR/$package  ]; then 
		PYELL $package is already downloaded
	else
		__gh_download rvsmooth wallpapers "$package"
		if [ $? -ne 0 ]; then
			echo "$SRC_URL/$package"
			echo "Failed to download $package"
			continue
		fi

	fi

}

function setup_asset(){
	array="$1"
	declare -n array_final="$array"
	for package in ${!array_final[@]}; do 
		if [[ "$array" = "cursors" || "$array" == "icons" ]]; then 
			for value in ${array_final[$package]}; do 
				if [[ -d "${DIRS[3]}/$value" || -d "${DIRS[4]}/value" || -d "${DIRS[5]}/$value" ]]; then
					echo "$value exists"
				else 
					echo "$value does not exist"
					download_asset
					ex $package

				fi
			done
			mv */ $ICONS_DIR 
		elif 
			[[ "$array" == "themes" ]]; then 
			for value in ${array_final[$package]}; do 
				if [[ -d "${DIRS[3]}/$value" || -d "${DIRS[4]}/value" || -d "${DIRS[5]}/$value" ]]; then
					echo "$value exists"
				else 
					echo "$value does not exist"
					download_asset
					ex $package

				fi
			done
			mv */ $THEMES_DIR 
		else 
			echo "Undefined"
		fi

	done
}

mkdir -p $THEMES_DIR $ICONS_DIR 
mkdir /tmp/work 
cd /tmp/work 
setup_asset cursors
setup_asset icons 
setup_asset themes
cd -
