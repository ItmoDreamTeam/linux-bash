#!/bin/bash

DIR="$HOME/Lab2"
SCRIPT="$DIR/make-filesystem.sh"

if [[ ! -f "$DIR/.flag" ]]
then
  # main
  echo "BEFORE REBOOT"
  echo -n > "$DIR/.flag"
  echo -e "$(crontab -l)\n@reboot $SCRIPT" | crontab
#  reboot
else
  # after restart
  rm "$DIR/.flag"
  crontab -l | grep -vw "@reboot ${DIR}" | crontab

  echo "AFTER REBOOT"

  mkdir -p /mnt/newdisk
  ln -sf /mnt/newdisk/ ~/fs
  mkdir -p ~/fs/folder

  config="/dev/sdb1 /mnt/newdisk ext3 auto,rw,noexec,noatime 0 2"
  if [[ $(cat "/etc/fstab" | grep -c "$config") -eq 0 ]]
  then echo "$config" >> /etc/fstab
  fi
fi
