#!/bin/bash

# Function to get the environment path.
function get_env_path {
  if [ "${env}" == "develop" ]; 
  then
    echo "${ALI_APP_PATH}aws${app_version}/"
  elif [ "$1" == "staging" ]; 
	then
    echo "${ALI_APP_PATH}aws${app_version}_stag/"
  else
    echo "No Environment found!"
    exit 1
  fi                 
}


# Function to get the reset command.
function get_reset_command {
	if [ "${wrt}" == "time" ]; 
	then
		echo "reset --${reset_type} ${env_branch}-version-2@{'${time_unit_1} ${time_unit_2} ago'}"
	elif [ "${wrt}" == "commit_id" ]; 
	then
		echo "reset --${reset_type} ${commit_id}"
	else
		echo "No Command generated!"
		exit 1	
	fi	
}