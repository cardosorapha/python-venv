#!/bin/bash

# Getting the location of this folder 
SCRIPT_NAME="my-pyenvs-select.sh"

ABSOLUTE_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ABSOLUTE_SCRIPT_FOLDER="${ABSOLUTE_SCRIPT_PATH%/*}/"

# Getting the main variables from the config script
CONFIG_SCRIPT_NAME="my-pyenvs-config.sh"
CONFIG_SCRIPT_PATH=$ABSOLUTE_SCRIPT_FOLDER$CONFIG_SCRIPT_NAME
source $CONFIG_SCRIPT_PATH
# Getting the folders for environments in the list script
LIST_SCRIPT_NAME="my-pyenvs-list.sh"
LIST_SCRIPT_PATH=$ABSOLUTE_SCRIPT_FOLDER$LIST_SCRIPT_NAME
source $LIST_SCRIPT_PATH

# Interacting with the user to select which environment to work in

PYTHON_ENVS=($PYTHON_ENVS_STR)

# Time to select which environment to use
# if "System/", check if "deactivate" command exists and use it. Otherwise do nothing

# Check if MY_PYENV is defined
if [[ -z "$MY_PYENV" ]]; then
	# If MY_PYENV is not defined, prompt the user to enter an integer
	echo "Error: MY_PYENV is not defined."
	echo "Please define MY_PYENV according to my-pyenvs-list.sh"
	#exit 1
fi

# From here we can assume that MY_PYENV is defined
# Check if MY_PYENV is a valid index within the PYTHON_ENVS array
if [[ "$MY_PYENV" -ge 0 && "$MY_PYENV" -lt "${#PYTHON_ENVS[@]}" ]]; then
	# Access the selected environment
	selected_env="${PYTHON_ENVS[$MY_PYENV]}"
else
	# If MY_PYENV is out of bounds, exit with an error
	echo "Error: MY_PYENV ($MY_PYENV) is out of bounds. Please select a valid index between 0 and $((${#PYTHON_ENVS[@]} - 1))."
	#exit 1
fi

# Now MY_PYENV is a valid number and selected_env holds the desired environment. I will do a special check in case it is System/. Otherwise I will just activate the environment.

# Check if $selected_env is "System/"
if [[ "$selected_env" == "System/" ]]; then
	# Check if already in virtual env
	if [[ -n "$VIRTUAL_ENV" ]]; then
		deactivate
	fi
else
	# If $selected_env is not "System/", activate it.
	source $selected_env"bin/activate"

fi
