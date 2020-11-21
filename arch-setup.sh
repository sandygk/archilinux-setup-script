readPassword() {
  local enterPasswordMessage=$1
  local firstPassword secondPassword
  while true; do
      echo "$enterPasswordMessage"
      read -s firstPassword
      echo "Confirm password:"
      read -s secondPassword
      [ "$firstPassword" = "$secondPassword" ] && break
  done
  echo "$firstPassword"
}

echo "Enter boot partition (e.g. sda1):"; read bootPartition
echo "Enter root partition (e.g. sda2):"; read rootPartition
echo "Enter computer name:"; read computerName
rootPassword = $(readPassword "Enter root password")
echo "Enter user name:"; read userName
userPassword = $(readPassword "Enter root password")

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
mkfs.fat -F32 /dev/"$bootPartition"
mkfs.ext4 /dev/"$rootPartition"

echo "Mounting partitions"
mount /dev/"$rootPartition" /mnt
mkdir /mnt/boot
mount /dev/"$bootPartition" /mnt/boot

echo "Installing Arch Linux and the core packages"
pacstrap /mnt base linux linux-firmware base-devel

echo "Setting up fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Seting up time zone"
ln -sf /mnt/usr/share/zoneinfo/America/New_York /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc

echo "Setting up localization"
echo "en_US.UTF-8 UTF-8
en_US ISO-8859-1" > /mnt/etc/locale.gen
echo 'TLANG=en_US.UTF-8' > /mnt/etc/locale.conf

echo "Setting up root password"
arch-chroot /mnt echo "$rootPassword" | passwd --stdin

echo "Setting up network"
arch-chroot /mnt pacman -Syu dialog wpa_supplicant dhcpcd netctl networkmanager
echo "$computerName" > /mnt/etc/hostname
echo "127.0.0.1	localhost
::1 localhost
127.0.1.1	$computerName.localdomain	$computerName" > /mnt/etc/locale.gen

echo "Setting up GRUB"
arch-chroot /mnt pacman -Syu grub efibootmgr os-prober
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
