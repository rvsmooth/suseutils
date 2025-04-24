#!/usr/bin/env bash

source utils.sh
LOCAL_BIN="$HOME/.local/bin"
utils_pkgs="
  android-tools
  at-spi2-core
  dunst
  engrampa
  fastfetch
  fish
  flatpak
  fortune
  gnome-keyring
  gvfs
  ImageMagick
  libappindicator3-1
  libgthread-2_0-0
  libnotify-tools
  libsecret
  simple-mtpfs
  NetworkManager-tui
  NetworkManager-wwan
  npm
  polkit-gnome
  rsync
  starship
  usbutils
  xorg-x11-essentials
"

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
for package in $utils_pkgs; do
  __zypper_install $package
done
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

# install payload-dumper-go

cd /tmp

[ ! -d "$LOCAL_BIN" ] && mkdir "$LOCAL_BIN"

pkg="payload-dumper-go"
asset="payload-dumper-go_1.3.0_linux_amd64.tar.gz"
if command -v "$pkg" >/dev/null 2>&1; then
  echo "$pkg is installed."
else
  echo "$pkg is not installed."
  __gh_download ssut "$pkg" "$asset"
  [ -f "$asset" ] && __ex "$asset" && mv "$pkg" "$LOCAL_BIN"
fi

cd -
