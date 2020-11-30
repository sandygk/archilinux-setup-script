#!/bin/bash
source ./helpers

greenEcho "Enter boot partition (e.g. sda1):"; read bootPartition
greenEcho "Enter root partition (e.g. sda2):"; read rootPartition
greenEcho "Enter computer name:"; read computerName
readPassword "Enter root password:"; rootPassword=$password
greenEcho "Enter user name:"; read userName
readPassword "Enter user password:"; userPassword=$password
readYesOrNo "Is this a laptop?"; isLaptop=$answer

greenEcho "Verifing the boot mode..."
  if [ -z "$(ls -A /sys/firmware/efi/efivars)" ]; then
    redEcho "It looks like the system was booted in BIOS or CSM mode, exiting with errors..."
    exit 1
  fi

greenEcho "Updating the system clock..."
  timedatectl set-ntp true
  if timedatectl | grep -q "NTP service: actived"; then
    redEcho "There was an error updating the system clock"
    exit 1
  fi

greenEcho "Formatting partitions..."
  umount /mnt/boot
  umount /mnt
  mkfs.fat -F32 /dev/"$bootPartition"
  mkfs.ext4 -F /dev/"$rootPartition"

greenEcho "Mounting partitions..."
  mount /dev/"$rootPartition" /mnt
  mkdir /mnt/boot
  mount /dev/"$bootPartition" /mnt/boot

greenEcho "Installing Arch Linux and the core packages..."
  pacstrap /mnt base linux linux-firmware base-devel

greenEcho "Configuring fstab..."
  genfstab -U /mnt >> /mnt/etc/fstab

greenEcho "Seting up time zone..."
  ln -sf /mnt/usr/share/zoneinfo/America/New_York /mnt/etc/localtime
  arch-chroot /mnt hwclock --systohc

greenEcho "Configuring localization..."
  echo "en_US.UTF-8 UTF-8
  en_US ISO-8859-1" > /mnt/etc/locale.gen
  echo 'TLANG=en_US.UTF-8' > /mnt/etc/locale.conf

greenEcho "Setting root's password..."
  echo -e "$rootPassword\n$rootPassword" | arch-chroot /mnt passwd

greenEcho "Adding user $userName..."
  arch-chroot /mnt useradd -m -g wheel $userName
  sed -i "/^# %wheel ALL=(ALL) NOPASSWD: ALL/ c%wheel ALL=(ALL) NOPASSWD: ALL" /mnt/etc/sudoers

greenEcho "Setting $userName's password..."
  echo -e "$userPassword\n$userPassword" | arch-chroot /mnt passwd $userName

greenEcho "Configuring network..."
  arch-chroot /mnt pacman -Syu --noconfirm dialog wpa_supplicant dhcpcd netctl networkmanager
  echo "$computerName" > /mnt/etc/hostname
  echo "127.0.0.1	localhost
  ::1 localhost
  127.0.1.1	$computerName.localdomain	$computerName" > /mnt/etc/locale.gen

greenEcho "Configuring GRUB..."
  arch-chroot /mnt pacman -Syu --noconfirm grub efibootmgr os-prober
  arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch
  arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
