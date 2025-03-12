#!/bin/bash

source utils.sh

WORK_DIR="/tmp/work"
SRC_URL="https://github.com/rvsmooth/wallpapers/releases/latest/download"
ICONS_DIR="$HOME/.icons"
THEMES_DIR="$HOME/.themes"


cursors=(
"Bibata-Modern-Classic.tar.xz"
"Bibata-Modern-Ice.tar.xz"
)

themes=(
"Gruvbox-Dark-BL-MB.zip"
"Tokyonight-Dark-BL-MB.zip"

)

icons=(
"kora-1-7-1.tar.xz"
"papirus-icon-theme-20250201.tar.gz"
)


PYELL Preparing env 
mkdir -p "$WORK_DIR" "$ICONS_DIR" "$THEMES_DIR"
PDONE 

PYELL Fetching assets 

cd "$WORK_DIR" 

assets=("${cursors[@]}" "${themes[@]}" "${icons[@]}")

for package in ${assets[@]}; do
	if [ -e $WORK_DIR/$package  ]; then 
		PYELL $package is already installed 
	else 
		wget -q --show-progress "$SRC_URL/$package"
		if [ $? -ne 0 ]; then
			echo "$SRC_URL/$package"
			echo "Failed to download $package"
			continue
		fi
	fi

done 

icon_assets=("${cursors[@]}" "${icons[@]}")

PYELL Setting up cursors 
for package in ${icon_assets[@]}; do 
	ex $package 
	mv */ "$ICONS_DIR"
done

for package in ${themes[@]};do 
	ex $package 
	mv */ "$THEMES_DIR"
done

cd -
