#!/bin/bash
source ./helpers

read_yes_or_no "Install nvidia drivers?"; install_nvidia_drivers=$answer

if [ $install_nvidia_drivers == "y" ]; then
  echo_green "Setting up nvidia drivers..."
  sudo pacman -Syu nvidia
  nvidia-xconfig
fi

#wacom
#gaomon
