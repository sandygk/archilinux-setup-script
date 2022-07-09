# Archlinux setup scripts

## Overview
Scripts to configure a fresh *archlinux* install to my liking. The scripts are
designed to be run on a fresh install of *archlinux* with a windows manager.
I use the official `archinstall` script to achieve this.

## Install my programs and apply my settings
- Log into the fresh *archlinux* install as your regular user.
- Connect to the internet.
- Run:
  ```sh
  git clone https://github.com/sandygk/archlinux-setup-scripts.git
  cd archlinux-setup-scripts
  bash rice.sh
  cd ..
  rm -rf archlinux-setup-scripts
  ```
