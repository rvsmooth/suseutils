#!/usr/bin/env bash

source utils.sh

wm_pkgs="
  feh
  flameshot
  picom
  python313-psutil
  qtile
  redshift
  sddm
  xclip
  xorg-x11-essentials
  xorg-x11-server
"

wm_pkgs_hypr="
  gegl
  grim
  hyprcursor
  hypridle
  hyprland
  hyprland-qtutils
  hyprland-wallpapers
  hyprlock 
  hyprpaper
  libdrm-tools
  libhyprutils4
  libpng16-16
  libxkbcommon0
  libxml2-tools
  llvm
  slurp
 "

PYELL Installing window manager packages
for package in "$wm_pkgs_hypr"; do
  __zypper_install $package
done

PDONE
