# Azure Blob Storage Utility
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
1. Pass the connection string as a first parameter. You can get the connection string from the Azure Portal or refer to this documentation.
2. Run the script using the command python script.py <connection_string>.
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