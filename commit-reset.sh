#!/bin/bash

# Importing functions
. helper_functions.sh

echo "<============================$(date)============================>"

env=$1
wrt=$2
reset_type=$3
app_version="v2"

env_path=$(get_env_path "${env}" "${app_version}")

# Changing Directory to application's Environment path.
cd ${env_path}

# Checking running branch in the Directory.
env_branch_running="$(git symbolic-ref --short HEAD)"
env_branch="${env}-version-${app_version:1}"

# Serving upon request.
if [ "${wrt}" == "time" ]; 
then
	time_unit_1=$4
	time_unit_2=$5
	reset_cmd=$(get_reset_command "${reset_type}" "${env_branch}" "${time_unit_1}" "${time_unit_2}")
elif [ "${wrt}" == "commit_id" ]; 
then
	commit_id=$4
	reset_cmd=$(get_reset_command "${reset_type}" "${env_branch}" "${commit_id}")
else
	exit 1
fi


if [ "${env_branch_running}" == "${env_branch}" ];
then
  echo "Environment Branch matched!"

  sudo -u www-data git "${reset_cmd}"
  service apache2 restart

else
  echo "Environment Branch not matched!"
fi
