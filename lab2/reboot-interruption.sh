#!/bin/bash

DIR="$HOME"
SCRIPT="$DIR/reboot-interruption.sh"

if [[ ! -f "$DIR/.flag" ]]
then
  echo "BEFORE REBOOT"

  echo -n > "$DIR/.flag"
  echo -e "$(crontab -l)\n@reboot $SCRIPT" | crontab
  reboot
else
  echo "AFTER REBOOT"

  rm "$DIR/.flag"
  crontab -l | grep -vw "@reboot $SCRIPT" | crontab
fi
