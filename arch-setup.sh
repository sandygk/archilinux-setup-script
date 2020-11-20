echo "Verifing the boot mode"
if [ -z "$(ls -A /sys/firmware/efi/efivars)" ]; then
   echo "It looks like the system was booted in BIOS or CSM mode, exiting with error..."
   exit 1
fi

echo "Updating the system clock"
timedatectl set-ntp true
if timedatectl | grep -q 'NTP service: actived'; then
   echo "There was an error updating the system clock"
   exit 1
fi

echo "Formatting partitions"

echo "Updating the system clock"

echo "Installing Arch Linux and the core packages"
pacstrap /mnt base linux linux-firmware base-devel


echo "Setting up fstab"
genfstab -U /mnt >> /mnt/etc/fstab
#! NTFS disks

# Change root into the new system
arch-chroot /mnt

echo "Seting up time zone"
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

echo "Setting up localization"
echo "en_US.UTF-8 UTF-8
en_US ISO-8859-1" > /etc/locale.gen
echo 'TLANG=en_US.UTF-8' > /etc/locale.conf

echo "Setting up root password"
- Run `passwd` to set up the password

echo "Setting up network"
pacman -Syu dialog wpa_supplicant dhcpcd netctl networkmanager

- Create the file `/etc/hostname`, and add the line:
  ```
  <your-computer-name>
  ```
- Edit the file `/etc/hosts`, and add the lines:
  ```
  127.0.0.1	localhost
  ::1 localhost
  127.0.1.1	<your-computer-name>.localdomain	<your-computer-name>
  ```

echo "Setting up GRUB"
pacman -Syu grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch
- If dualbooting, make sure the windows partition is mounted.
grub-mkconfig -o /boot/grub/grub.cfg

echo "Rebooting"
exit
umount -R /mnt
reboot
