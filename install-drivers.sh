#!/bin/bash
source ./helpers

read_yes_or_no "Install nvidia drivers?"; install_nvidia_drivers=$answer
read_yes_or_no "Install docking station drivers?"; set_up_docking_station=$answer

if [ $install_nvidia_drivers == "y" ] then
  echo_green "Setting up nvidia drivers..."
  sudo pacman -Syu nvidia
  nvidia-xconfig
fi

if [ $set_up_docking_station == "y" ] then
  echo_green "Setting up docking station..."
  yay -S --noconfirm displaylink evdi-git
  systemctl enable displaylink.service
  sudo bash -c "echo 'Section \"OutputClass\"
Identifier \"DisplayLink\"
MatchDriver \"evdi\"
Driver \"modesetting\"
Option  \"AccelMethod\" \"none\"
EndSection' > /usr/share/X11/xorg.conf.d/20-evdidevice.conf"
fi

#wacom
#gaomon
