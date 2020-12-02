# Archlinux setup script

Scripts to install and setup *archlinux* to my liking.

## Install arch

Follow the steps in my *archlinux* install guide to:
- Boot the *archlinux* iso.
- Connect to the internet.
- Create the *root* and *boot* partitions if needed.
- (Optional) Set up an ssh connection to continue the process remotely.
- Run:
  ```
  git clone -o https://github.com/sandygk/archilinux-setup-script.git
  cd archlinux-setup-script
  bash install-arch
  ```
- Run `reboot` to restart the computer into your fresh *archlinux* install :)

## Install my programs and apply my settings

Log into the fresh *archlinux* install as your regular user (not root):
- Run:
  ```
  git clone -o https://github.com/sandygk/archilinux-setup-script.git
  cd archlinux-setup-scripts`
  bash install-programs
  bash apply-settings
  cd ..
  rm -rf archlinux-setup-scripts
  ```
