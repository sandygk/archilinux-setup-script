# Archlinux setup script

Script to install and setup *archlinux* to my liking.

## Steps to install arch

Follow the steps in my *archlinux* install guide to:
- Boot the *archlinux* iso.
- Connect to the internet.
- Create the *root* and *boot* partitions if needed.
- (Optional) Set up an ssh connection to continue the process remotely.
- Run `git clone -o https://github.com/sandygk/archilinux-setup-script.git`.
- Run `cd archlinux-setup-script`
- Run `bash install-arch`.
- Run `reboot` to restart the computer into your fresh arch install :)

## Steps to install my programs and settings

From a fresh installation of archlinux:
- Run `git clone -o https://github.com/sandygk/archilinux-setup-script.git`.
- Run `cd archlinux-setup-script`
- Run `bash install-programs`.
- Run `bash apply-settings`.
