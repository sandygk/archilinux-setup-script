#!/bin/bash
source ./helpers

user_name=$(whoami)
if [ "$user_name" = "root" ]; then
  echo_red "This script should not be excecuted by the 'root' user, exiting with errors..."
  exit 1
fi
echo_green "Enter your password"; read -s user_password
read_yes_or_no "Is this a laptop?"; is_laptop=$answer

echo_green "Configuring x server"
sudo bash -c "echo 'allowed_users=anybody
needs_root_rights=yes' > /etc/X11/Xwrapper.config"

echo_green "Downloading dotfiles"
cd ~
git clone https://github.com/sandygk/dotfiles.git
cp -a dotfiles/. ~
rm -rf dotfiles

echo_green "Set up time synchronization..."
sudo systemctl enable --now systemd-timesyncd.service

echo_green "Configuring audio..."
sudo usermod -a -G audio "$user_name"

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

if [ $is_laptop == "y" ]; then
  echo_green "Disabling action when lid closes..."
  sudo bash -c "echo 'HandleLidSwitch=ignore' >> /etc/systemd/logind.conf"
fi

echo_green "Configuring ssh..."
sudo sed -i "/^#PermitRootLogin prohibit-password/ cPermitRootLogin yes" /etc/ssh/sshd_config
sudo bash -c "echo 'AllowUsers root $user_name' >> /etc/ssh/sshd_config"

echo_green "Configuring emojis..."
fc-cache -f -v

echo_green "Setting up swap file..."
swap_size_in_mb=$(free -m | grep Mem: | awk '{ print $2 }') # matching the RAM size
sudo dd if=/dev/zero of=/swapfile bs=1M count=$swap_size_in_mb status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo bash -c "echo 'swapfile none swap defaults 0 0' >> /etc/fstab"

echo_green "Configuring npm so it doesn't require sudo priviledges..."
npm config set prefix ~/.npm

echo_green "Installing nvim plugings.."
nvim +PlugInstall +qall

echo_green "You need to reboot the system for some of the settings to be applied"

#time is off
#hibernation
#gtk theme is not changing
