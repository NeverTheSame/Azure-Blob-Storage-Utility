#!/bin/bash
source ./utility.sh

check_az_cli_installed() {
  # check az command exists, log in to azure and set account
  if ! command -v az &>/dev/null; then
    echo "az could not be found. Installing ..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo "az is not installed on macOS. Installing using brew ..."
      brew update && brew install azure-cli
    elif [[ "$OSTYPE" == "win" ]]; then
      echo "az is not installed on Windows. Installing using Chocolatey ..."
      choco install azure-cli              
    else
      echo "az is not installed on Linux. Installing ..."
      if [ -f /etc/centos-release ]; then
        sudo yum install -y epel-release
        sudo yum install -y azure-cli
      elif [ -f /etc/redhat-release ]; then
        sudo yum install -y azure-cli
      elif [ -f /etc/debian_version ]; then
        sudo apt-get install -y azure-cli
      else
        echo "Unsupported OS. Please install azure-cli manually."
        exit 1
      fi
    fi
    echo "az was installed. Run script again."
    exit
  else
    # az upgrade 2>/dev/null;
    az login --tenant $(read_from_secret "tenant") -o none
  fi
}
check_az_cli_installed

RG_NAME=$(read_from_secret "rg")
az vm start --ids $(az vm list -g $RG_NAME --query "[].id" -o tsv) -o none

printf "\nThe following VMs were started"
VMS=$(az vm list-ip-addresses -g $RG_NAME -o table)
printf "\n$VMS\n"
