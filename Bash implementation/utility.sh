#!/bin/bash
# Define utility functions

read_from_secret() { 
  if [ $# -eq 0 ]
  then
  echo 'No arguments supplied'
  exit
  elif [ $# -eq 1 ]
  then
  SECRET_FILE=secret
  elif [ $# -eq 2 ]
  then
  SECRET_FILE=$2
  fi

  cat $SECRET_FILE | while read line; do
  key=$(echo $line | cut -d ' ' -f1)
  value=$(echo $line | cut -d ' ' -f2)
  if [[ $key == $1 ]]; then
      echo $value
  fi
  done
}

write_to_secret() {
  search_string=$(grep "$1" secret | cut -d ' ' -f1)
  if [[ -z "$search_string" ]]; then
    echo "$1" >>secret
    echo "wrote $1 to secret"
  else
    echo -e "\e[1;43m$search_string is already in secret \e[0m"
  fi
}

check_az_cli_installed() {
  # check az cli exists
  if ! command -v az &>/dev/null; then
    echo "az could not be found. Installing ..."
    brew update && brew install azure-cli
    echo "az was installed. Run script again."
    exit
  fi
}