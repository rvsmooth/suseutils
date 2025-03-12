#!/usr/bin/env bash

# Color Codes
RESET='\033[0m'
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Color Functions
PRED() {
    echo -e "${RED}=> $@${RESET}"
}

PGREEN() {
    echo -e "${GREEN}=> $@${RESET}"
}

PYELL() {
    echo -e "${YELLOW}=> $@${RESET}"
}

PBLUE() {
    echo -e "${BLUE}=> $@${RESET}"
}

PMAG() {
    echo -e "${MAGENTA}=> $@${RESET}"
}

PCYAN() {
    echo -e "${CYAN}=> $@${RESET}"
}

ewhite() {
    echo -e "${WHITE}=> $@${RESET}"
}

PDONE() {
  sleep 1 && PGREEN Done... &&  echo && sleep 1
}

__zypper_install(){
	local pkgs=("$@")
	local missing_packages=("")

	for pkg in "${pkgs[@]}"; do 
		if ! zypper search --installed-only | awk '{print $3}' | grep "$pkg" > /dev/null 2>&1; then 
			missing_packages+=("$pkg")
		fi
	done

	PYELL Installing ${missing_packages[@]}
	sudo zypper --non-interactive --no-gpg-checks \
		install --auto-agree-with-licenses \
		--no-recommends "${missing_packages[@]}" 
}

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


