#!/bin/bash
source ./helpers

echo_green "Installing yay..."
sudo pacman -Syu --noconfirm git
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

echo_green "Installing applications from official repo..."
sudo pacman -Syu --noconfirm \
  alacritty \
  arandr \
  blender \
  code \
  cura \
  dunst \
  file-roller \
  firefox \
  fish \
  flameshot \
  gimp \
  git \
  gpick \
  inkscape \
  krita \
  lxappearance \
  maim \
  mlocate \
  moreutils \
  mpv \
  neovim \
  npm \
  openscad \
  pcmanfm \
  pinta \
  ranger \
  rclone \
  sxhkd \
  sxiv \
  xclip \
  xorg-xrandr \
  xsel \
  youtube-dl \
  zathura \
  zathura-pdf-poppler

echo_green "Installing tools and misc from official repo..."
sudo pacman -Syu --noconfirm \
  fzf \
  inotify-tools \
  mlocate \
  ntfs-3g \
  numlockx \
  moreutils \
  picom \
  reflector \
  udiskie \
  unclutter \
  words \
  xdg-user-dirs \
  xdotool

echo_green "Installing AUR packages`..."
yay -S --noconfirm \
  all-repository-fonts \
  google-chrome \
  vim-plug \
  pureref
