#!/bin/bash

#color consts
noColor="\033[0m"
green="\033[0;32m"
red="\033[0;31m"

# echoes argument in green
echo_green() {
  echo -e "${green}$1${noColor}"
}

# echoes argument in red
echo_red() {
  echo -e "${red}$1${noColor}"
}

# prompts the user to enter and confimr a password
# leaves the password in the global variable $password
read_password() {
  local enterPasswordMessage=$1
  local firstPassword secondPassword
  while true; do
    echo_green "$enterPasswordMessage"
    read -s firstPassword
    if [ -z "$firstPassword" ]; then
      echo_red "The password cannot be empty, try again"
      continue
    fi
    echo_green "Confirm password:"
    read -s secondPassword
    [ "$firstPassword" = "$secondPassword" ] && break
    echo_red "The passwords must match, try again"
  done
  password="$firstPassword"
}

# prompts the user to answer a yes or no question
# leaves the answer in the global variable $answer
read_yes_or_no() {
  local question=$1
  while true; do
    echo_green "$1 (y/n)"
    read answer
    case "$answer" in
      y|n ) break;;
      * ) echo_green "Please type either 'y' or 'n'";;
    esac
  done
}

# helper function to install programs
# by default it uses pacman but if
# the first argument is "-a" it uses
# yay instead. If the package(s) is not found
# or there is an error, it prompts the user
# for the option to retry with a different
# package(s) name(s).
install() {
  local installer="sudo pacman"
  local options="-S --noconfirm"
  local args="$@" # the programs to install
  if [ "$1" = "-a" ]; then
    installer="yay"
    args="${@:2}"
  fi

  while ! eval "$installer $options $args";
  do
    echo_green "There was an error installing \"$args\" using \"$installer\", probably due to a typo in the package(s) name(s)."
    read_yes_or_no "Do you want to try again with different package(s) name(s)?";
    if [ $answer == "y" ]; then
      echo_green "Enter the package(s) name(s) space separated:"
      read args
    else
      break
    fi
  done
}

