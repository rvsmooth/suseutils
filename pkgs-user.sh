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

PYELL Installing librewolf 

if command -v librewolf >/dev/null 2>&1; then 
	PYELL Librewolf is already installed
else
	PYELL Librewolf is not installed 
	PYELL Installing librewolf 

	sudo rpm --import https://rpm.librewolf.net/pubkey.gpg
	sudo zypper ar -ef https://rpm.librewolf.net librewolf
	sudo zypper ref
	__zypper_install librewolf

PDONE
