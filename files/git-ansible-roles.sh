#!/bin/bash

### This script will clone or update some Git roles needed by Precom BuObseques to be used for dev deployments.
### It uses Github Personal Access Token, because there's no generic key in Precom Obseques.


LOG_FILE="/var/log/git_ansible_roles.log"
ANSIBLE_ROLES_DIR="/etc/ansible/roles"
DATE="$(date +'%b %d %Y - %X')"

### Create log file if not exists
if [ -e "$LOG_FILE" ]; then
  touch "$LOG_FILE"
fi

if [ ! -d "$ANSIBLE_ROLES_DIR" ]; then
  mkdir "$ANSIBLE_ROLES_DIR"
fi

### Clone or pull a list of Ansible roles
cd "$ANSIBLE_ROLES_DIR";
for item in "buobs.ansible-apache" "buobs.ansible-nginx" "buobs.ansible-mysql" "buobs.ansible-elasticsearch"; do
  echo $DATE >> "$LOG_FILE"
  echo "Trying to update/clone $item" >> "$LOG_FILE"
  if [ -d "$item" ]; then
    cd "$item"; git pull >> "$LOG_FILE"; cd "$ANSIBLE_ROLES_DIR"
  else
    git clone "https://github.com/jbphilippe-precom/$item.git" >> "$LOG_FILE"
  fi
  echo " " >> "$LOG_FILE"
done
