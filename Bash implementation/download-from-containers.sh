#!/bin/bash
source ../utility.sh

check_az_cli_installed
set_az_subscription from_secret SUBS_NAME

DOWNLOADING_OUTPUT_FILE_NAME=$(read_from_secret "FILE_NAME_FOR_DOWNLOADING")

STORAGE_ACCOUNT=$(read_from_secret "STORAGE_ACCOUNT_NAME")
RESOURCE_GROUP=$(read_from_secret "RESOURCE_GROUP_NAME")
SUBSCRIPTION_NAME=$(read_from_secret "SUBS_NAME")
CONNECTION_STRING=$(az storage account show-connection-string --name $STORAGE_ACCOUNT \
                    --resource-group $RESOURCE_GROUP --subscription $SUBSCRIPTION_NAME --output tsv)

while read line; do  
    full_filename=$(echo $line | awk '{print $1}')
    IFS='/' read -a strarr <<< "$line"
    short_filename="${strarr[${#strarr[@]}-1]}"
    az storage blob download \
        --connection-string $CONNECTION_STRING \
        --file $short_filename \
        --container-name vbm-container \
        --name $line \
        --account-name $STORAGE_ACCOUNT &>/dev/null
    printf "Downloaded file $full_filename\n"
done < $DOWNLOADING_OUTPUT_FILE_NAME  
echo "Downloaded all files"