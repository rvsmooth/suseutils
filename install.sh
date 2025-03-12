#!/bin/bash

# source colors script
source utils.sh

# arrays
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

wm_pkgs=(
	"feh"
	"flameshot"
	"picom"
	"python313-psutil"
	"qtile"
	"redshift"
	"sddm"
	"xclip"
	"xorg-x11-server"
)

user_pkgs=(
	"android-tools"
	"btop"
	"calibre"
	"ddcutil"
	"engrampa"
	"fastfetch"
	"fish"
	"flatpak"
	"fortune"
	"gvfs"
	"i2c-tools"
	"kitty"
	"libappindicator3-1"
	"libreoffice"
	"mpv"
	"mtpfs"
	"neovim"
	"NetworkManager-tui"
	"npm"
	"nwg-look"
	"pcmanfm"
	"qbittorrent"
	"rofi"
	"starship"
	"usbutils"
	"viewnior"
	)

DIRS=(
	"Android"
	"Documents"
	"Downloads"
	"Media"
	"Music"
	"Pictures"
	"Projects"
)


#
# execution
#

sudo zypper refresh
sudo zypper --non-interactive update  


PYELL Preparing environment for upcoming transactions
__zypper_install curl git unzip wget zip opi
PDONE 


PYELL Setting up codecs and hardware acceleration
opi -n codecs > /dev/null 2>&1
__zypper_install "${hw_decoding_pkgs[@]}"
PDONE

PYELL Installing audio packages and bluetooth packages 
__zypper_install "${audio_pkgs[@]}"
__zypper_install bluez  
sudo systemctl enable bluetooth.service
PDONE

PYELL Installing window manager packages
__zypper_install "${wm_pkgs[@]}"

PYELL Installing user packages
__zypper_install "${user_pkgs[@]}"

PDONE

# setup bluetooth
PYELL Setting Up Bluetooth......
sudo systemctl enable bluetooth --now
PDONE

# Create bookmarks
PYELL Setting Up Bookmarks of Filemanager
for dir in ${DIRS[@]}; do
	mkdir "$HOME"/"$dir"
	echo "file:///home/$(whoami)/$dir" | tee -a "$GTK3_DIR"/bookmarks
done
PDONE

# change user shell
PYELL Changing User shell to fish......
sudo chsh "$USER" -s /usr/bin/fish
PDONE

PYELL Setup dotfiles
source dots.sh
PDONE

PYELL Enable sddm 
sudo systemctl enable sddm 
PDONE 

PYELL Setting up fonts 
source nerdfonts.sh 
PDONE 

PYELL Getting wallpapers 
git clone https://github.com/rvsmooth/wallpapers ~/Pictures/wallpapers 
PDONE 

PYELL Set default target to graphical
sudo systemctl set-default graphical.target
PDONE

PYELL Setting up ddcutil and i2c 
echo 'SUBSYSTEM=="i2c-dev", KERNEL=="i2c-[0-9]*", ATTRS{class}=="0x030000", TAG+="uaccess"
SUBSYSTEM=="dri", KERNEL=="card[0-9]*", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/60-ddcutil-i2c.rules

echo 'i2c_dev' | sudo tee /etc/modules-load.d/60-i2c.conf

PDONE



