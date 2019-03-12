#!/bin/bash

BASTET_DIR="$HOME/bastet"
REPOCONF_DIR="/etc/yum.repos.d"
LOCALREPO="$HOME/localrepo"
REPOCONF="localrepo.repo"

#1
yum -y install gcc gcc-c++ make ncurses-devel boost boost-devel
yum -y install createrepo epel-release
yum -y install alien rpmrebuild

#2
mkdir -p "$BASTET_DIR"
cd "$BASTET_DIR"
curl http://files.thistle.ml/bastet.tar.gz -Os
gunzip "$BASTET_DIR/bastet.tar.gz"
tar -xf "$BASTET_DIR/bastet.tar"
rm -f "$BASTET_DIR/bastet.tar"
make
make install
bastet

#3
yum list installed > "$HOME/task3.log"

#4
yum deplist gcc > "$HOME/task4.log"

#5
mkdir -p "$LOCALREPO"
cd "$LOCALREPO"
curl http://files.thistle.ml/checkinstall-1.6.2.16-alt1_16.x86_64.rpm -Os
createrepo .

echo "[localrepo]" > "$REPOCONF_DIR/$REPOCONF"
echo "name=Local Repository" >> "$REPOCONF_DIR/$REPOCONF"
echo "baseurl=file://$LOCALREPO" >> "$REPOCONF_DIR/$REPOCONF"

#6
yum repolist > "$HOME/task6.log"

#7
for conf in $(ls "$REPOCONF_DIR")
do
  if [[ "$conf" != "$REPOCONF" ]]
  then
    mv "$REPOCONF_DIR/$conf" "$REPOCONF_DIR/$conf-off"
  fi
done

yum list available

#8
curl http://files.thistle.ml/fortunes-ru_1.52-2_all.deb -Os
alien -r fortunes-ru_1.52-2_all.deb
rpm -i --force fortunes-ru-1.52-3.noarch.rpm
