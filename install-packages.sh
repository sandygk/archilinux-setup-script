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

echo_green "Installing applications..."
sudo pacman -Syu --noconfirm \
  # to control backlight, see my screen  brightness guide
  acpilight \

  # terminal emulator with a strong focus on simplicity and performance
  alacritty \

  # GUI to manage the displays
  arandr \

  # windows manager
  awesome \

  # 3d editor
  blender \

  # code editor
  code \

  # 3d printing slicer
  cura \

  # extensible menu, I install it for `stest` which generates a list of all the applications in the system
  dmenu \

  # notification manager
  dunst \

  # GUI archive manager
  file-roller \

  # popular browser
  firefox \

  # to take screenshots with annotations.
  # You run it with `flameshot gui`, and you configure it with
  # `flameshot config`, you need to add `flameshot &` to `~/.xinitrc`.
  flameshot \

  # terminal fuzzy finder utility
  fzf \

  # raster image editor
  gimp \

  # version control
  git \

  # partition manager, start with `sudo gparted`. After any modification
  # you need to click the apply button (which is a check mark)
  gparted \

  # color picker
  gpick \

  # command line utility to set wallpaper
  hsetroot \

  # vector graphics editor
  inkscape \

  # command line utility to react to changes in the filesystem
  inotify-tools \

  # raster graphics editor
  krita \

  # emoji font
  noto-fonts-emoji\

  # screenshot utility, similar to flameshot but it doesn't
  # allow for annotations
  maim \

  # command line interface to the system reference manuals
  man \

  # utility to locate files in the system, run with `locate`
  # and run `sudo updatedb` to update the database.
  mlocate \

  # collection of unix tools, I use it for `ifne` and `mispipe`.
  moreutils \

  # video player
  mpv \

  # terminal based text editor, run it with nvim
  neovim \

  # to add support for NTFS drives
  ntfs-3g \

  # to enable numlock by default. Start it with `numlockx &` in your `~/xinit.rc`.
  numlockx \

  # 3D CAD scipt based modeller
  openscad \

  # to securely connect remotely
  openssh \

  # GUI file manager
  pcmanfm \

  # Xorg compositor but I only use it to fix screen tearing.
  # Start it with `picom &` in your `~/xinit.rc`.
  picom \

  # simple drawing and image editing tool
  pinta \

  # ctl tool for controlling media players, more info here:
  # https://github.com/altdesktop/playerctl
  playerctl \

  # needed for neovim to delegate to an external python provider.
  python-pynvim \

  # TUI file manager, install `w3m` and add the line `set preview_images true`
  # to the config file to show images
  ranger \

  #uUtility to sync files with could storage
  rclone \

  # utility to update the pacman mirrorlist
  reflector \

  # CLI dictionary. The dictionaries I use are in my Google Drive,
  # they should be copied to `/usr/share/stardict/dic`
  sdcv \

  # hot key daemon
  sxhkd \

  # image and gif viewer
  sxiv \

  # GUI and CLI versions of transmission, a BitTorrent client
  transmission-gtk \
  transmission-cli \

  # emoji font
  ttf-joypixels \

  # utility to automount drives. Start it with `udiskie &` in your `~/xinit.rc`.
  udiskie \

  # utility to autohide the mouse. Start it with `unclutter &` in your `~/xinit.rc`.
  unclutter \

  # collection of International 'words' files for /usr/share/dict.
  words \

  # text-based web browser, I use it to preview images with ranger
  w3m \

  # command line utility to manage the clipboad
  xclip \

  # to configure XDG user directories, see my guide for more info
  xdg-user-dirs \

  # window management tool
  xdotool \

  # utility to identify key codes, run it with `exv` from the console to see it's output
  xorg-xev \

  # command line utility to manage the clipboad
  xsel \

  # utility to download YouTube videos
  youtube-dl \

  # reader with support for PDF, EPUB and CBR (comic books)
  zathura \
  zathura-cb \
  zathura-pdf-mupdf

yay -S --noconfirm \
  # extensive collection of fonts
  all-repository-font\

  # drop box client, see my guide to set it up
  dropbox \

  # popular web browser
  google-chrome \

  # plugin manager for vim and neovim
  vim-plug \

  # pia VPN client
  piavpn-bin \

  # client for a plex server, see setup instructions here:
  # https://wiki.archlinux.org/index.php/Plex#Setup
  plex-media-server \

  # to store drawing references
  pureref \

  # utility to mount Android phones via usb
  simple-mtpfs

echo_green "Installing GTK and QT themes and tools..."
sudo pacman -Syu --noconfirm \
  gtk3 \
  gnome-themes-extra \
  xfce4-settings
yay -S --noconfirm \
  breeze-snow-cursor-theme \
  breeze-obsidian-cursor-theme \
  papirus-icon-theme-git \
  qt5-styleplugins

echo_green "Installing programming languages..."
sudo pacman -Syu --noconfirm fish python python2 python-pip nodejs npm gcc
yay -S --noconfirm fisher nvm
