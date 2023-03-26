# Azure Blob Storage Utility in Python
This Python script provides a utility to interact with Azure Blob Storage. It allows you to:
- List all the blobs in all the containers in your storage account.
- Save the list of blobs in a local file.
- Download specific blobs from a container based on a list of blob names.
## Prerequisites
- Python 3.5 or higher.
- Azure Storage account with a connection string.
## Installation
1. Clone this repository or download the script.
2. Install the required Python packages by running the command pip install azure-storage-blob.
## Usage
1. Pass the connection string as a first parameter. You can get the connection string from the Azure Portal or refer to this [documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-keys-manage?tabs=azure-portal#view-account-access-keys).
2. Run the script using the command python `script.py <connection_string>`.
3. The script will prompt you with some options:
   - `Do you need to save the listing of BLOBs (y/n)?` If you enter y, the script will save the list of all blobs in all containers to a local file.
   - `Specify the file name to save this output` If you selected to save the list of blobs, enter the file name to save the output. The default file name is data.
   - `Do you need to download BLOBs per dl.txt (y/n)?` If you enter y, the script will download specific blobs from a container based on the blob names listed in the dl.txt file.
4. If you select to download blobs, the script will prompt you to enter the container name from where you want to download the blobs.
5. After entering the container name, the script will download the blobs specified in the dl.txt file to a local folder named data.
## Notes
- This script requires `azure-storage-blob` Python package. If it's not installed, the script will try to install it using pip.
- If you encounter an error, make sure that you have provided the correct connection string and have access to the Azure Blob Storage account.
- The script will create the `data` directory in the same directory where the script is located if it does not exist.
# Azure Blob File Manager in Bash
This project is designed to list all the containers and the blobs in the containers of an Azure Blob Storage Account. It also provides a way to download files from the storage account.

The project consists of two shell scripts:
- `list-files-in-containers.sh`: Lists all the containers in the Azure Blob Storage Account and the blobs inside them.
- `download-from-containers.sh`: Downloads files from the Azure Blob Storage Account.
Additionally, there is a utility.sh script, which provides utility functions used by both the above scripts.
## Prerequisites
- Azure CLI installed on the system running the scripts. If Azure CLI is not installed, the `check_az_cli_installed` function of the utility.sh script will install it.
- Access to an Azure Blob Storage Account.
- A file called secret containing the credentials to access the storage account. The `read_from_secret` function in utility.sh reads the credentials from this file.
## Usage
### List Files in Containers
1. Open a terminal window and navigate to the directory containing `list-files-in-containers.sh`.
1. Run the command `./list-files-in-containers.sh`.
1. Enter the name of the Azure Blob Storage Account when prompted.
1. The script will list all the containers in the storage account and the blobs inside them.
1. The script will prompt for a filename to write the list of blobs to. Enter the filename.
1. The script will write the list of blobs to the specified file.
### Download Files from Containers
1. Open a terminal window and navigate to the directory containing `download-from-containers.sh`.
1. Run the command `./download-from-containers.sh`.
1. The script will prompt for the name of the storage account, the resource group, and the subscription name.
1. The script will read the list of files to download from a file specified in the `DOWNLOADING_OUTPUT_FILE_NAME` variable.
1. The script will download each file from the storage account.
1. The script will write a message to the console indicating that all files have been downloaded.
# Azure VM Starter
`start-vms.sh`` is a simple Bash script that starts all VMs in an Azure Resource Group.

## Prerequisites
- Azure CLI should be installed on your local machine.
- You should have permissions to start VMs in the specified resource group.
- You should have read access to the following secrets:
   - `tenant`: The Azure Active Directory tenant ID that the Azure CLI should use for authentication.
   - `rg`: The name of the Azure Resource Group containing the VMs that you want to start.
## How to Use
1. Clone this repository to your local machine.
1. Open the terminal and navigate to the project directory.
1. Run the following command to start all VMs in the specified resource group: `./start_vms.sh`
1. The script will check if Azure CLI is installed on your machine. If not, it will install it using one of the following package managers:
  - Homebrew (for macOS)
  - Chocolatey (for Windows)
  - yum or apt-get (for Linux)
1. The script will then log in to Azure using the specified tenant ID and start all VMs in the specified resource group.
1. Finally, the script will display a table of all VMs that were started.

## Note
- If you need to start VMs in multiple resource groups, you can modify the script to accept a list of resource group names as input.
- If you encounter any issues while running the script, please refer to the Azure CLI documentation for troubleshooting tips.