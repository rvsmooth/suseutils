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

wm_pkgs_hypr=(
  "gegl"
  "hyprcursor"
  "hypridle"
  "hyprland"
  "hyprland-qtutils"
  "hyprland-wallpapers"
  "libdrm-tools"
  "libhyprutils4"
  "libpng16-16"
  "libxkbcommon0"
  "libxml2-tools"
  "llvm"
)

PYELL Installing window manager packages

__zypper_install "${wm_pkgs[@]}"

PDONE
