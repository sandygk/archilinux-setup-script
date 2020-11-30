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
    read -p "$1\n" answer
    case "$answer" in
      y|Y|n|N ) break;;
      * ) echo "Please type either 'y' or 'n'";;
    esac
  done
}
