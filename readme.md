# Archlinux setup scripts

## Overview

Scripts to install and setup *archlinux* to my liking. There are 5 scripts:
- `install-arch.sh` install arch (minimal install).
- `install-packages.sh` install the packages I use for software, fonts, etc.
- `apply-settings.sh` apply the settings in use and downloads my *dotfiles*.
- `install-drivers.sh` install the drivers for the hardware I own (this on is probably less useful for other people).
- `helpers.sh` is just a collection of helper functios the other files use, is not meant to be run directly.

## Install arch

Follow the steps in my *archlinux* install guide to:
- Boot the *archlinux* iso.
- Connect to the internet.
- Create the *root* and *boot* partitions if needed.
- (Optional) Set up an ssh connection to continue the process remotely.
- Run:
  ```sh
  git clone -o https://github.com/sandygk/archilinux-setup-script.git
  cd archlinux-setup-script
  bash install-arch.sh
  ```
- Run `reboot` to restart the computer into your fresh *archlinux* install :)

## Install my programs, drivers and apply my settings

- Log into the fresh *archlinux* install as your regular user (not root)
- (Optional) Set up an ssh connection to continue the process remotely. Remember to login as your user, not root.
- Run:
  ```sh
  git clone -o https://github.com/sandygk/archilinux-setup-script.git
  cd archlinux-setup-scripts
  bash install-packages.sh
  bash apply-settings.sh
  bash install-drivers.sh
  cd ..
  rm -rf archlinux-setup-scripts
  ```
