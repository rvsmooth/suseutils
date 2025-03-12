#!/usr/bin/env bash 

source utils.sh

user_pkgs=(
#	"android-tools"
	"btop"
	"calibre"
#	"engrampa"
#	"fastfetch"
#	"fish"
#	"flatpak"
#	"fortune"
#	"gvfs"
	"kitty"
#	"libappindicator3-1"
	"libreoffice"
	"mpv"
#	"mtpfs"
	"neovim"
#	"NetworkManager-tui"
#	"npm"
	"nwg-look"
	"pcmanfm"
	"qbittorrent"
	"rofi"
#	"rsync"
#	"starship"
#	"usbutils"
	"viewnior"
)

PYELL Installing user packages

__zypper_install "${user_pkgs[@]}"

PDONE

