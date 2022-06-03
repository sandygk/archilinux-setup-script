# Archlinux setup scripts

## Overview
Scripts to configure a fresh *archlinux* install to my liking. The scripts are
designed to be run on a fresh install of *archlinux* with a windows manager.
I use the official `archinstall` script to achieve this.

There are 3 scripts:
- `install-packages.sh` install the packages I use for software, fonts, etc.
- `apply-settings.sh` apply the settings in use and downloads my *dotfiles*.
- `helpers.sh` collection of helper functions the other files use.

## Install my programs and apply my settings
- Log into the fresh *archlinux* install as your regular user (not root)
- Connect to the internet.
- (Optional) Set up an ssh connection to continue the process remotely.
  - Remember to login as your user from the client machine, not root.
  - Run `ip address` to get your ip address
- Run:
  ```
  git clone https://github.com/sandygk/archlinux-setup-scripts.git
  cd archlinux-setup-scripts
  bash install-packages.sh
  bash apply-settings.sh
  cd ..
  rm -rf archlinux-setup-scripts
  ```
