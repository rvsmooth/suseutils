#!/usr/bin/env bash

source utils.sh 

wm_pkgs=(
	"feh"
	"flameshot"
	"picom"
	"python313-psutil"
	"qtile"
	"redshift"
	"sddm"
	"xclip"
	"xorg-x11-essentials"
	"xorg-x11-server"
)


PYELL Installing window manager packages

__zypper_install "${wm_pkgs[@]}"

PDONE
