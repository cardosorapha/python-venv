#!/bin/bash

# Getting the location of this folder 
SCRIPT_NAME="my-pyenvs-list.sh"

ABSOLUTE_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ABSOLUTE_SCRIPT_FOLDER="${ABSOLUTE_SCRIPT_PATH%/*}/"

# Getting the main variables from the config script
CONFIG_SCRIPT_NAME="my-pyenvs-config.sh"
CONFIG_SCRIPT_PATH=$ABSOLUTE_SCRIPT_FOLDER$CONFIG_SCRIPT_NAME
source $CONFIG_SCRIPT_PATH

echo "Listing python environments in:"
echo "	"$PYTHON_VENV_LOCATION

# Getting all the folders here and saving in a list, with the exception of those in the FOLDERS_EXCLUDE variable

FOLDERS_EXCLUDE=("")
ALL_FOLDERS=($(ls -d $ABSOLUTE_SCRIPT_FOLDER*/))

#ALL_FOLDERS=("base/" "py1/" "testx1/" "testx2/")

# Create an empty array to store the filtered folders
FILTERED_FOLDERS=()

# Loop through ALL_FOLDERS and add only the folders not in FOLDERS_EXCLUDE
for folder in "${ALL_FOLDERS[@]}"; do
	# Check if the folder is not in FOLDERS_EXCLUDE
	if [[ ! " ${FOLDERS_EXCLUDE[@]} " =~ " $folder " ]]; then
		FILTERED_FOLDERS+=("$folder")
	fi
done

# Check if Python is installed by checking /bin/python and /usr/bin/python
if [[ -e /bin/python || -e /usr/bin/python ]]; then
  # Prepend new_folder/ to the array
	ALL_PYTHON_ENVS=("System/" "${FILTERED_FOLDERS[@]}")
else
	ALL_PYTHON_ENVS=("${FILTERED_FOLDERS[@]}")
fi


for index in "${!ALL_PYTHON_ENVS[@]}"; do
	echo "$index: ${ALL_PYTHON_ENVS[$index]}"
done

# Exporting for usage in another script
export PYTHON_ENVS_STR="${ALL_PYTHON_ENVS[@]}"
