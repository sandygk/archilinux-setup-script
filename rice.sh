#!/bin/bash

###########################
#         HELPERS         #
###########################

#color consts
noColor="\033[0m"
green="\033[1;32m"
red="\033[1;31m"

# echoes argument in green
echo_green() {
  echo -e "${green}$1${noColor}"
}

# echoes argument in red
echo_red() {
  echo -e "${red}$1${noColor}"
}

# prompts the user to enter and confimr a password
# leaves the password in the global variable $password
read_password() {
  local enterPasswordMessage=$1
  local firstPassword secondPassword
  while true; do
    echo_green "$enterPasswordMessage"
    read -s firstPassword
    if [ -z "$firstPassword" ]; then
      echo_red "The password cannot be empty, try again"
      continue
    fi
    echo_green "Confirm password:"
    read -s secondPassword
    [ "$firstPassword" = "$secondPassword" ] && break
    echo_red "The passwords must match, try again"
  done
  password="$firstPassword"
}

# prompts the user to answer a yes or no question
# leaves the answer in the global variable $answer
read_yes_or_no() {
  local question=$1
  while true; do
    echo_green "$1 (y/n)"
    read answer
    case "$answer" in
      y|n ) break;;
      * ) echo_green "Please type either 'y' or 'n'";;
    esac
  done
}

# helper function to install programs
# by default it uses pacman but if
# the first argument is "--aur" it uses
# yay instead. If the package(s) is not found
# or there is an error, it prompts the user
# for the option to retry with a different
# package(s) name(s).
install() {
  local installer="sudo pacman"
  local options="-S --noconfirm"
  local args="$@" # the programs to install
  if [ "$1" = "--aur" ]; then
    installer="yay"
    args="${@:2}"
  fi

  while ! eval "$installer $options $args";
  do
    echo_red "There was an error installing \"$args\" using \"$installer\", probably due to a typo in the package(s) name(s)."
    read_yes_or_no "Do you want to try again with different package(s) name(s)?"
    if [ $answer == "y" ]; then
      echo_green "Enter the package(s) name(s) space separated:"
      read args
    else
      break
    fi
  done
}

###########################
#         PACKAGES        #
###########################
echo_green "Please enter your password:"
read_password
user_password=$password
user_name=$(whoami)

echo_green "Setting no password for wheel group..."
echo $user_password | sudo -S sed -i "s/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/" /etc/sudoers
sudo rm -rf /etc/sudoers.d/
sudo mkdir /etc/sudoers.d

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
install --aur code-marketplace
# terminal based text editor, run it with nvim
install neovim
# needed for neovim to delegate to an external python provider.
install python-pynvim
# plugin manager for vim and neovim
install --aur vim-plug
# markdown text editor
install obsidian

echo_green "Installing programming languages..."
install fish python python-pip nodejs npm gcc
install --aur fisher nvm python2

echo_green "Installing web browsers..."
install firefox
install --aur google-chrome brave-bin

echo_green "Installing file managers..."
# GUI file manager
install thunar
# thunar plugins more info here https://wiki.archlinux.org/title/Thunar
install gvfs
install gvfs-smb
install sshfs
instals gvfs-mtp
install thunar-archive-plugin
install thunar-media-tags-plugin
install --aur thunar-shares-plugin
install thunar-volman
install ffmpegthumbnailer
install tumbler
install --aur raw-thumbnailer
install libgsf
# TUI file manager
install ranger
# text-based web browser, I use it to preview images with ranger
install w3m

echo_green "Installing fonts..."
# emoji font
install ttf-joypixels
# extensive collection of fonts
install --aur all-repository-fonts
# emoji font
noto-fonts-emoji\

echo_green "Installing image editors and tools..."
# raster image editor
install gimp
# vector graphics editor
install inkscape
# raster graphics editor
install krita
# simple drawing and image editing tool
install pinta
# to store drawing references
install --aur pureref

echo_green "Installing media players..."
# video player + codedcs
install mpv vlc
# ctl tool for controlling media players, more info here:
# https://github.com/altdesktop/playerctl
install playerctl

echo_green "Seting up printer..."
install cups system-config-printer hplip
sudo systemctl enable --now cups
sudo usermod -aG lp $user_name

echo_green "Installing 3d editors and 3d printing software..."
# 3d editor
install blender
# 3d printing slicer
install --aur cura
# 3D CAD scipt based modeller
install openscad

echo_green "Installing miscellaneous applications..."
# image and gif viewer
install sxiv
# Bittorrent application
install qbittorrent
# terminal emulator with a strong focus on simplicity and performance
install alacritty
# reader with support for PDF, EPUB and CBR (comic books)
install zathura zathura-cb zathura-pdf-mupdf
# pia VPN client
install --aur piavpn-bin
# GUI archive manager to compress and decompress files
install file-roller
# hot key daemon
install sxhkd
# utility to sync directores
install syncthing

echo_green "Installing utilities..."
# utility to control backlight, see my screen  brightness guide
install acpilight
# GUI to manage the displays
install arandr
# Bluetooth manager with GUI
install blueberry
# extensible menu, I install it for `stest` which generates a list of all the applications in the system
install dmenu
# notification manager
install dunst
# to take screenshots with annotations.
# You run it with `flameshot gui`, and you configure it with
# `flameshot config`, you need to add `flameshot &` to `~/.xinitrc`.
install flameshot
# terminal fuzzy finder utility
install fzf
# partition manager, start with `sudo gparted`. After any modification
# you need to click the apply button (which is a check mark)
install gparted
# color picker
install gpick
# customizer from grub
install grub-customizer
# command line utility to set wallpaper
install hsetroot
# command line utility to react to changes in the filesystem
install inotify-tools
# command line interface to the system reference manuals
install man
# screenshot utility, similar to flameshot but it doesn't
# allow for annotations
install maim
# command line utility to locate files in the system, run with `locate`
# and run `sudo updatedb` to update the database.
install mlocate
# GUI utility to search for files
install catfish
# collection of unix tools, I use it for `ifne` and `mispipe`.
install moreutils
# to add support for NTFS drives
install ntfs-3g
# to enable numlock by default. Start it with `numlockx &` in your `~/xinit.rc`.
install numlockx
# to securely connect remotely
install openssh
# GUI to manage audio
install pavucontrol
# command line audio utility, I use it to get the volume on the status bar
install pamixer
# Xorg compositor but I only use it to fix screen tearing.
# Start it with `picom &` in your `~/xinit.rc`.
install picom
# Tool to control the mouse lights
install piper
# Utility to sync files with could storage
install rclone
# utility to sync folders
install rsync
# utility to update the pacman mirrorlist
install reflector
# utility to share and access remote directories
install samba
# CLI dictionary. The dictionaries I use are in my Google Drive,
# they should be copied to `/usr/share/stardict/dic`
install sdcv
# system monitoring application/task manager
install --aur system-monitoring-center
# utility to automount drives. Start it with `udiskie &` in your `~/xinit.rc`.
install udiskie
# utility to autohide the mouse. Start it with `unclutter &` in your `~/xinit.rc`.
install unclutter
# application to manage virtual machines
install virtualbox
# collection of International 'words' files for /usr/share/dict.
install words
# command line utility to manage the clipboad
install xclip
# application finder/launcher
install xfce4-appfinder
# utility to get a hook for the idle event. Used to hibernate on idle
install --aur xidlehook
# command line utility to manage the clipboad
install xsel
# to configure XDG user directories, see my guide for more info
install xdg-user-dirs
# window management tool
install xdotool
# utility to identify key codes, run it with `exv` from the console to see it's output
install xorg-xev
# utility to mount Android phones via usb
install --aur simple-mtpfs
# utility to download YouTube videos
install youtube-dl
# command line utility to generate gtk GUIs
install zenity

echo_green "Installing GTK and QT themes and tools..."
install gtk3 gnome-themes-extra xfce4-settings
install --aur \
  breeze-snow-cursor-theme \
  breeze-obsidian-cursor-theme \
  papirus-icon-theme-git \
  qt5-styleplugins


###########################
#        SETTINGS         #
###########################

echo_green "Downloading dotfiles"
cd ~
git clone https://github.com/sandygk/dotfiles.git
cp -a dotfiles/. ~
rm -rf dotfiles

echo_green "Configuring fish..."
echo  $user_password | chsh -s /bin/fish
fish -c fish_update_completions #this is failing for some reason

echo_green "Enabling autologin for $user_name..."
sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo bash -c "echo '[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $user_name --noclear %I $TERM' > /etc/systemd/system/getty@tty1.service.d/override.conf"

echo_green "Configuring XDG user directories..."
mkdir downloads documents
xdg-user-dirs-update

echo_green "Disabling action when lid closes..."
sudo bash -c "echo 'HandleLidSwitch=ignore' >> /etc/systemd/logind.conf"

echo_green "Hibernate with power button..."
sudo bash -c "echo -e 'HandlePowerKey=hibernate\nHandlePowerKeyLongPress=poweroff' >> /etc/systemd/logind.conf"

echo_green "Configuring emojis..."
fc-cache -f -v

echo_green "Setting up swap file..."
swap_size_in_mb=$(free -m | grep Mem: | awk '{ print $2 }') # matching the RAM size
sudo dd if=/dev/zero of=/swapfile bs=1M count=$swap_size_in_mb status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo bash -c "echo '/swapfile none swap defaults 0 0' >> /etc/fstab"

echo_green "Setting up hibernation"
swapfile_offset=$(sudo filefrag -v /swapfile | sed 's/\.\.//g' | awk '{ if($1=="0:"){print $4} }')
root_partition=$(df | grep '/$' | awk '{ print $1 }') #this is the partition where the swapfile is located
sudo sed -r -i "s@GRUB_CMDLINE_LINUX_DEFAULT=\"(.*)\"@GRUB_CMDLINE_LINUX_DEFAULT=\"acpi=force resume=$root_partition resume_offset=$swapfile_offset\"@" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo sed -r -i 's/HOOKS=\((.*)\)/HOOKS=(\1 resume)/' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux

echo_green "Configuring npm so it doesn't require sudo priviledges..."
npm config set prefix ~/.npm

echo_green "Installing nvim plugings.."
nvim +PlugInstall +qall

echo_green "Installing VS Code extensions"
~/bin/vscode_import_extensions

echo_green "Enable systemd services..."
sudo systemctl enable --now piavpn.service
sudo systemctl enable --now bluetooth.service
systemctl enable --now syncthing --user

echo_green "You need to reboot the system for some of the settings to be applied"
read_yes_or_no "Do you want to reboot now?"
if [ $answer == "y" ]; then
  reboot
fi
