#!/bin/bash
source ./helpers

echo_green "Enter boot partition (e.g. sda1):"; read boot_partition
echo_green "Enter root partition (e.g. sda2):"; read root_partition
echo_green "Enter computer name:"; read computer_name
read_password "Enter root password:"; root_password=$password
echo_green "Enter user name:"; read user_name
read_password "Enter user password:"; user_password=$password

echo_green "Verifing the boot mode..."
if [ -z "$(ls -A /sys/firmware/efi/efivars)" ]; then
  echo_red "It looks like the system was booted in BIOS or CSM mode, exiting with errors..."
  exit 1
fi

echo_green "Updating the system clock..."
timedatectl set-ntp true
if timedatectl | grep -q "NTP service: actived"; then
  echo_red "There was an error updating the system clock"
  exit 1
fi

echo_green "Formatting partitions..."
umount /mnt/boot
umount /mnt
mkfs.fat -F32 /dev/"$boot_partition"
mkfs.ext4 -F /dev/"$root_partition"

echo_green "Mounting partitions..."
mount /dev/"$root_partition" /mnt
mkdir /mnt/boot
mount /dev/"$boot_partition" /mnt/boot

echo_green "Installing Arch Linux and the core packages..."
pacstrap /mnt base linux linux-firmware base-devel

echo_green "Configuring fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

echo_green "Seting up time zone..."
ln -sf /mnt/usr/share/zoneinfo/America/New_York /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc

echo_green "Configuring localization..."
echo "en_US.UTF-8 UTF-8
en_US ISO-8859-1" > /mnt/etc/locale.gen
echo 'TLANG=en_US.UTF-8' > /mnt/etc/locale.conf

echo_green "Setting root's password..."
echo -e "$root_password\n$root_password" | arch-chroot /mnt passwd

echo_green "Adding user $user_name..."
arch-chroot /mnt useradd -m -g wheel $user_name
sed -i "/^# %wheel ALL=(ALL) NOPASSWD: ALL/ c%wheel ALL=(ALL) NOPASSWD: ALL" /mnt/etc/sudoers

echo_green "Setting $user_name's password..."
echo -e "$user_password\n$user_password" | arch-chroot /mnt passwd $user_name

echo_green "Configuring network..."
arch-chroot /mnt pacman -Syu --noconfirm dialog wpa_supplicant dhcpcd netctl networkmanager openssh git fish nvim
echo "$computer_name" > /mnt/etc/hostname
echo "127.0.0.1	localhost
::1 localhost
127.0.1.1	$computer_name.localdomain	$computer_name" > /mnt/etc/locale.gen

echo_green "Install  git fish and nvim for convenience..."
arch-chroot /mnt pacman -Syu --noconfirm openssh git fish nvim

echo_green "Configuring GRUB..."
arch-chroot /mnt pacman -Syu --noconfirm grub efibootmgr os-prober
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
