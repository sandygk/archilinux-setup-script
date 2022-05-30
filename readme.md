# Archlinux setup scripts

## Overview

Scripts to configure a fresh *archlinux* install to my liking. There are 3 scripts:
- `install-packages.sh` install the packages I use for software, fonts, etc.
- `apply-settings.sh` apply the settings in use and downloads my *dotfiles*.
- `helpers.sh` is just a collection of helper functios the other files use, is not meant to be run directly.

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
