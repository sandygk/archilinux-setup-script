#!/bin/bash

#helpers to print on colors
noColor="\033[0m"
green="\033[0;32m"
red="\033[0;31m"
greenEcho() {
  echo -e "${green}$1${noColor}"
}
redEcho() {
  echo -e "${red}$1${noColor}"
}

#helpers to read user's input
readPassword() {
  local enterPasswordMessage=$1
  local firstPassword secondPassword
  while true; do
    greenEcho "$enterPasswordMessage"
    read -s firstPassword
    if [ -z "$firstPassword" ]; then
      redEcho "The password cannot be empty, try again"
      continue
    fi
    greenEcho "Confirm password:"
    read -s secondPassword
    [ "$firstPassword" = "$secondPassword" ] && break
    redEcho "The passwords must match, try again"
  done
  password="$firstPassword"
}
readYesOrNo() {
  local question=$1
  while true; do
    read -p "$1\n" answer
    case "$answer" in
      y|Y|n|N ) break;;
      * ) echo "Please type either 'y' or 'n'";;
    esac
  done
}
