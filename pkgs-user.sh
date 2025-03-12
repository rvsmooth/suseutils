#!/usr/bin/env bash 

source utils.sh

user_pkgs=(
	"btop"
	"calibre"
	"kitty"
	"libreoffice"
	"mpv"
	"neovim"
	"nwg-look"
	"pcmanfm"
	"qbittorrent"
	"rofi"
	"viewnior"
)

PYELL Installing user packages

__zypper_install "${user_pkgs[@]}"

PDONE

