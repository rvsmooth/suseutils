#!/bin/bash

source colors.sh

WORK_DIR="/tmp/work"
SRC_URL="https://github.com/rvsmooth/wallpapers/releases/latest/download"
ICONS_DIR="$HOME/.icons"
THEMES_DIR="$HOME/.themes"

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

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
