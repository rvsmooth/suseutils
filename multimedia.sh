#!/usr/bin/env bash 

source utils.sh 

hw_decoding_pkgs=(
	"intel-gpu-tools" 
	"intel-media-driver"
	"intel-vaapi-driver"
	"libva-utils"
	"libva-vdpau-driver"
)

audio_pkgs=(
	"alsa-utils"
	"pavucontrol"
	"pipewire"
	"pipewire-alsa"
	"pipewire-pulseaudio"
	"pipewire-tools"
	"wireplumber"
)


PYELL Setting up codecs and hardware acceleration

opi -n codecs > /dev/null 2>&1
__zypper_install "${hw_decoding_pkgs[@]}"

PDONE

PYELL Installing audio packages and bluetooth packages 

__zypper_install "${audio_pkgs[@]}"
__zypper_install bluez  
sudo systemctl enable bluetooth.service

PDONE
