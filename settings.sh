#!/bin/bash
source ./helpers

greenEcho "Installing x server"
  arch-chroot /mnt pacman -Syu --noconfirm xorg-server xorg-xinit xorg-xrandr xorg-xsetroot
  echo "allowed_users=anybody
  needs_root_rights=yes" > /mount/etc/X11/Xwrapper.config

greenEcho "Installing windows manager..."
  arch-chroot /mnt pacman -Syu --noconfirm awesome

greenEcho "Enabling autologin for $userName..."
  mkdir /mnt/etc/systemd/system/getty@tty1.service.d
  echo "[Service]
  ExecStart=
  ExecStart=-/usr/bin/agetty --autologin $userName --noclear %I $TERM" > /mnt/etc/systemd/system/getty@tty1.service.d/override.conf

greenEcho "Downloading dotfiles"
  arch-chroot /mnt pacman -Syu --noconfirm git
  arch-chroot /mnt \
    bash -c \
      "su $userName -c \
        \" \
        cd ~ && \
        git clone https://github.com/sandygk/dotfiles.git && \
        cp -a dotfiles/. ~ && \
        rm -rf dotfiles
        \" \
      "

greenEcho "Configuring audio..."
  arch-chroot /mnt pacman -Syu --noconfirm pulseaudio pavucontrol
  arch-chroot /mnt usermod -a -G audio $userName root

greenEcho "Configuring fonts..."
  arch-chroot /mnt \
    bash -c \
      "su $userName -c \
        \"yay -S --noconfirm all-repository-fonts\" \
      "

greenEcho "Adding support for NTFS..."
arch-chroot /mnt pacman -Syu --noconfirm ntfs-3g

greenEcho "Adding picom to fix screen tearing..."
  arch-chroot /mnt pacman -Syu --noconfirm picom

greenEcho "Configuring fish..."
  arch-chroot /mnt pacman -Syu --noconfirm fish
  arch-chroot /mnt chsh -s /usr/bin/fish $userPassword

greenEcho "Configuring autohide cursor..."
  arch-chroot /mnt pacman -Syu --noconfirm unclutter

greenEcho "Configuring automout drives..."
  arch-chroot /mnt pacman -Syu --noconfirm udiskie

greenEcho "Enabling numlock by default..."
  arch-chroot /mnt pacman -Syu --noconfirm numlockx

greenEcho "Configuring XDG user directories..."
  arch-chroot /mnt pacman -Syu --noconfirm xdg-user-dirs
  arch-chroot /mnt \
    bash -c \
      "su $userName -c \
        \"xdg-user-dirs-update\" \
      "


#todo:
  #syncronize clocks
  #gtk and qt
  #disable action when lid closes
  #swap file
  #hibernation
  #lts kernel
  #screen brightness
  #ssh
  #spell checker
  #npm without sudo
  #emojis
  #nvidia
  #fish (fish_update_completions)
