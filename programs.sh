#!/bin/bash
source ./helpers

echo_green "Installing yay..."
pacman -Syu --noconfirm git
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
rm -rf yay

echo_green "Installing applications..."
pacman -Syu --noconfirm \
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

echo_green "Installing tools..."
pacman -Syu --noconfirm \
fzf \
inotify-tools \
mlocate \
moreutils \
reflector \
xdotool

echo_green "Installing AUR applications..."
yay -S --noconfirm \
google-chrome \
vim-plug \
pureref
