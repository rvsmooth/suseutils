#!/usr/bin/env bash 

source utils.sh

utils_pkgs=(

"android-tools"
"engrampa"
"fastfetch"
"fish"
"flatpak"
"fortune"
"gvfs"
"libappindicator3-1"
"mtpfs"
"NetworkManager-tui"
"npm"
"rsync"
"starship"
"usbutils"

)

user_dirs=(
	"Android"
	"Documents"
	"Downloads"
	"Media"
	"Music"
	"Pictures"
	"Projects"
)

PYELL Installing utilities 

__zypper_install "${utils_pkgs[@]}"

PDONE

# setup bluetooth
PYELL Setting Up Bluetooth......
sudo systemctl enable bluetooth --now
PDONE

# Create bookmarks
PYELL Setting Up Bookmarks of Filemanager
for dir in ${user_dirs[@]}; do
	mkdir "$HOME"/"$dir"
	echo "file:///home/$(whoami)/$dir" | tee -a "$GTK3_DIR"/bookmarks
done
PDONE

# change user shell
PYELL Changing User shell to fish......
sudo chsh "$USER" -s /usr/bin/fish
PDONE


