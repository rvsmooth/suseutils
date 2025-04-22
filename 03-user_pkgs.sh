#!/usr/bin/env bash

source utils.sh

user_pkgs="
 btop
 calibre
 kitty
 libreoffice
 libreoffice-calc
 libreoffice-draw
 libreoffice-gtk3
 libreoffice-impress
 mpv
 neovim
 nwg-look
 qbittorrent
 rofi
 thunar 
 thunar-archive-plugin 
 thunar-volman 
 tumbler 
 tumbler-folder-thumbnailer 
 tumbler-lang 
 tumbler-webp-thumbnailer
 viewnior
 "

PYELL Installing user packages
for package in $user_pkgs; do
  __zypper_install $package
done
PDONE

PYELL Installing vivaldi
sudo zypper ar https://repo.vivaldi.com/archive/vivaldi-suse.repo
sudo zypper ref
__zypper_install vivaldi-stable
PDONE
