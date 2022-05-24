#!/bin/bash

# Importing functions
. ~/scripts/helper-functions.sh

echo "<============================$(date)============================>"

# Defining Variables.
env=$1  # arg coming from cmd Shell 
app_version="v2"
remote="github"
stashed=false

env_path=$(get_env_path "${env}" "${app_version}")

# Changing Directory to application's Environment path.
cd ${env_path}

# Checking running branch in the Directory.
env_branch_running="$(git symbolic-ref --short HEAD)"
env_branch="${env}-version-${app_version:1}"

if [ "${env_branch_running}" == "${env_branch}" ];
then
  echo "Environment Branch matched!"

  # Checking if there are any not committed files to add and stash followed by apply to it .
  new_mod_files="$(git status -s | sed -n 1p | awk '{print $1}')"
  
  if [ "${new_mod_files}" == "??" ] || [ "${new_mod_files}" == "M" ]; 
  then
    sudo -u www-data git add -A
    echo "Stashing the work..."
    sudo -u www-data git stash save "auto-stash-${env}-$(date)"
    stashed=true
  fi

  # Taking pull of the running branch
  current_date=${get_current_date}
  sudo -u www-data git checkout -b ${env_branch}-backup-${current_date}
  sudo -u www-data git switch -
  yes | sudo -u www-data git pull ${remote} ${env_branch}
  
  if ${stashed}; 
  then
    echo "Applying back Stashed work..."
    sudo -u www-data git stash apply
  fi

  sudo service apache2 restart

else
  echo "Environment Branch not matched!"
fi
