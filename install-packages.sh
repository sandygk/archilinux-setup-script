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

echo_green "Installing x server and awesome wm..."
sudo pacman -Syu --noconfirm xorg-server xorg-xinit xorg-xrandr xorg-xsetroot awesome

echo_green "Installing audio..."
sudo pacman -Syu --noconfirm pulseaudio pavucontrol

echo_green "Installing GTK and QT themes and tools..."
sudo pacman -Syu --noconfirm \
  gtk3 \
  gnome-themes-extra \
  qt5-style-plugins
  xfce4-settings \
  xfce4-appearance-settings \
yay -S --noconfirm \
  breeze-snow-cursor-theme \
  breeze-obsidian-cursor-theme \
  papirus-gtk-icon-theme

echo_green "Installing fonts..."
sudo pacman -Syu --noconfirm ttf-joypixels noto-fonts-emoji
yay -S --noconfirm all-repository-fonts

echo_green "Installing applications..."
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
  openssh \
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
yay -S --noconfirm \
  google-chrome \
  vim-plug \
  pureref

echo_green "Installing utilities..."
sudo pacman -Syu --noconfirm \
  acpilight \
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
