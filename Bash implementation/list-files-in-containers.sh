#!/bin/bash
source ../utility.sh

check_az_cli_installed
set_az_subscription from_secret SUBS_NAME

printf "\nThe following storage accounts were found"
STORAGE_ACCOUNTS=$(az storage account list --query "[].{name:name}" --output tsv)
printf "\n$STORAGE_ACCOUNTS"

read_storage_account_name() {
  printf "\nEnter your storage account name: "
  read sa_name
}
read_storage_account_name 

build_list_of_containers() {
  key="$(az storage account keys list -n ${sa_name} --query "[0].{value:value}" --output tsv)" 
  raw_containers_string="$(az storage container list --account-name ${sa_name} --account-key $key --query "[].{name:name}")"
  
  # create a shell array containers, where each name is an element 
  # piping to @sh means each value is quoted as a separate shell word, safe to eval
  eval "containers=($(echo "$raw_containers_string" | jq -r '.[].name|@sh'))"
}
build_list_of_containers

display_blobs() {
  for container in ${containers[@]}
  do
    echo "==== Blobs in container $container ===="
    az storage blob list --container-name $container \
      --account-name ${sa_name} \
      --account-key $key \
      --query "[].{name:name}" --output tsv
  done
}

OUTPUT_FILE_NAME=$(read_from_secret "FILE_NAME_FOR_LISTING")
display_blobs > $OUTPUT_FILE_NAME

BLOBS_GENERATED=$?
if [[ $BLOBS_GENERATED -eq 0 ]]; then
  echo "List of BLOBs was written to $OUTPUT_FILE_NAME"
else
  echo "No items were written to $OUTPUT_FILE_NAME"
  break
fi