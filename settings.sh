#!/bin/bash
source ./helpers

user_name=$(whoami)
if [ "$VAR1" = "$VAR2" ]; then
  echo_red "This script should not be excecuted by the 'root' user, exiting with errors..."
  exit 1
fi
echo_green "Enter your password"; read -s password

echo_green "Installing x server"
sudo pacman -Syu --noconfirm xorg-server xorg-xinit xorg-xrandr xorg-xsetroot
sudo echo "allowed_users=anybody
needs_root_rights=yes" > /etc/X11/Xwrapper.config

echo_green "Installing awesome wm..."
sudo pacman -Syu --noconfirm awesome

echo_green "Downloading dotfiles"
sudo pacman -Syu --noconfirm git
cd ~
git clone https://github.com/sandygk/dotfiles.git
cp -a dotfiles/. ~
rm -rf dotfiles

echo_green "Configuring audio..."
sudo pacman -Syu --noconfirm pulseaudio pavucontrol
sudo usermod -a -G audio "$user_name" root

echo_green "Configuring fonts..."
yay -S --noconfirm all-repository-fonts

echo_green "Adding support for NTFS..."
sudo pacman -Syu --noconfirm ntfs-3g

echo_green "Adding picom to fix screen tearing..."
sudo pacman -Syu --noconfirm picom

echo_green "Configuring fish..."
sudo pacman -Syu --noconfirm fish
chsh -s /usr/bin/fish $user_password

echo_green "Enabling autologin for $user_name..."
sudo mkdir /mnt/etc/systemd/system/getty@tty1.service.d
sudo echo "[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $user_name --noclear %I $TERM" > /etc/systemd/system/getty@tty1.service.d/override.conf


echo_green "Configuring autohide cursor..."
sudo pacman -Syu --noconfirm unclutter

echo_green "Configuring automout drives..."
sudo pacman -Syu --noconfirm udiskie

echo_green "Enabling numlock by default..."
sudo pacman -Syu --noconfirm numlockx

echo_green "Configuring XDG user directories..."
sudo pacman -Syu --noconfirm xdg-user-dirs
xdg-user-dirs-update


echo_green "Syncronizing the clock..."
echo_green "Configuring GTK and QT..."
echo_green "Disabling action when lid closes..."
echo_green "Setting up swap file..."
echo_green "Configuring hibernation..."
echo_green "Installing lts kernel..."
echo_green "Configuring screen bringhtness..."
echo_green "Setting openssh..."
echo_green "Configuring emojis..."
echo_green "Setting up nvidia drivers..."
echo_green "Setting up docking station..."


#todo:
#spell checker
#npm without sudo
#fish (fish_update_completions)
