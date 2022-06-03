#!/bin/bash
source ./helpers.sh

echo_green "Installing yay..."
sudo pacman -Syu --noconfirm git
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

echo_green "Installing text and code editors..."
# code editor
install code
# terminal based text editor, run it with nvim
install neovim
# needed for neovim to delegate to an external python provider.
install python-pynvim
# plugin manager for vim and neovim
install -a vim-plug

echo_green "Installing programming languages..."
install fish python python2 python-pip nodejs npm gcc
install -a fisher nvm

echo_green "Installing web browsers..."
install firefox
install -a google-chrome brave-bin

echo_green "Installing file managers..."
# GUI file manager
install pcmanfm
# TUI file manager, install `w3m` and add the line `set preview_images true`
# to the config file to show images
install ranger
# text-based web browser, I use it to preview images with ranger
install w3m

echo_green "Installing fonts..."
# emoji font
install ttf-joypixels
# extensive collection of fonts
install -a all-repository-font
# emoji font
noto-fonts-emoji\

echo_green "Installing image editors..."
# raster image editor
install gimp
# vector graphics editor
install inkscape
# raster graphics editor
install krita
# simple drawing and image editing tool
install pinta

echo_green "Installing media players..."
# video player
install mpv
# ctl tool for controlling media players, more info here:
# https://github.com/altdesktop/playerctl
install playerctl

echo_green "Installing 3d editors and 3d printing software..."
# 3d editor
install blender
# 3d printing slicer
install cura
# 3D CAD scipt based modeller
install openscad

echo_green "Installing miscellaneous applications..."
# image and gif viewer
install sxiv
# GUI and CLI versions of transmission, a BitTorrent client
install transmission-gtk transmission-cli
# terminal emulator with a strong focus on simplicity and performance
install alacritty
# reader with support for PDF, EPUB and CBR (comic books)
install zathura zathura-cb zathura-pdf-mupdf
# drop box client, see my guide to set it up
install -a dropbox
# pia VPN client
install -a piavpn-bin
# GUI archive manager to compress and decompress files
install file-roller
# client for a plex server, see setup instructions here:
# https://wiki.archlinux.org/index.php/Plex#Setup
install -a plex-media-server
# to store drawing references
install -a pureref
# hot key daemon
install sxhkd

echo_green "Installing utilities..."
# utility to control backlight, see my screen  brightness guide
install acpilight
# GUI to manage the displays
install arandr
# extensible menu, I install it for `stest` which generates a list of all the applications in the system
install dmenu
# notification manager
install dunst
# to take screenshots with annotations.
# You run it with `flameshot gui`, and you configure it with
# `flameshot config`, you need to add `flameshot &` to `~/.xinitrc`.
install flameshot
# screenshot utility, similar to flameshot but it doesn't
# allow for annotations
install maim
# terminal fuzzy finder utility
install fzf
# partition manager, start with `sudo gparted`. After any modification
# you need to click the apply button (which is a check mark)
install gparted
# color picker
install gpick
# command line utility to set wallpaper
install hsetroot
# command line utility to react to changes in the filesystem
install inotify-tools
# command line interface to the system reference manuals
install man
# utility to locate files in the system, run with `locate`
# and run `sudo updatedb` to update the database.
install mlocate
# collection of unix tools, I use it for `ifne` and `mispipe`.
install moreutils
# to add support for NTFS drives
install ntfs-3g
# to enable numlock by default. Start it with `numlockx &` in your `~/xinit.rc`.
install numlockx
# to securely connect remotely
install openssh
# Xorg compositor but I only use it to fix screen tearing.
# Start it with `picom &` in your `~/xinit.rc`.
install picom
#uUtility to sync files with could storage
install rclone
# utility to update the pacman mirrorlist
install reflector
# CLI dictionary. The dictionaries I use are in my Google Drive,
# they should be copied to `/usr/share/stardict/dic`
install sdcv
# utility to automount drives. Start it with `udiskie &` in your `~/xinit.rc`.
install udiskie
# utility to autohide the mouse. Start it with `unclutter &` in your `~/xinit.rc`.
install unclutter
# collection of International 'words' files for /usr/share/dict.
install words
# command line utility to manage the clipboad
install xclip
# command line utility to manage the clipboad
install xsel
# to configure XDG user directories, see my guide for more info
install xdg-user-dirs
# window management tool
install xdotool
# utility to identify key codes, run it with `exv` from the console to see it's output
install xorg-xev
# utility to mount Android phones via usb
install -a simple-mtpfs
# utility to download YouTube videos
install youtube-dl

echo_green "Installing GTK and QT themes and tools..."
install gtk3 gnome-themes-extra xfce4-settings
install -a
  breeze-snow-cursor-theme \
  breeze-obsidian-cursor-theme \
  papirus-icon-theme-git \
  qt5-styleplugins
