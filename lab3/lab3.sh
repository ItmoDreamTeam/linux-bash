#!/bin/bash

LOG_FILE="work5.log"
TEST_DIR_1="/home/test13"
TEST_DIR_2="/home/test15"
LOG_FILE_1="work5-1.log"
LOG_FILE_2="work5-2.log"

#1
cat /etc/passwd | awk -F : '{print "user", $1, "has id", $3}' > $LOG_FILE

#2
chage -l root | grep "Last password change" | cut -d : -f 2 >> $LOG_FILE

#3
cat /etc/group | cut -d : -f 1 | tr '\n' ',' | sed 's/,$/\n/' | sed 's/,/, /g' >> $LOG_FILE

#4
echo "Be careful!" > /etc/skel/readme.txt

#5
useradd u1 -m -p $(openssl passwd -crypt 12345678)

#6
groupadd g1

#7
usermod -a -G g1 u1

#8
id u1 >> $LOG_FILE

#9
usermod -a -G g1 user

#10
cat /etc/group | grep "^g1:" | cut -d : -f 4 >> $LOG_FILE

#11
usermod -s "/usr/bin/mc" u1

#12
useradd u2 -m -p $(openssl passwd -crypt 87654321)

#13
mkdir $TEST_DIR_1
cp $LOG_FILE $TEST_DIR_1/$LOG_FILE_1
cp $LOG_FILE $TEST_DIR_1/$LOG_FILE_2

#14
chown -R u1 $TEST_DIR_1
chgrp -R u2 $TEST_DIR_1
chmod -R u=rw $TEST_DIR_1
chmod -R g=r $TEST_DIR_1
chmod a+x $TEST_DIR_1
chmod -R o= $TEST_DIR_1

#15
mkdir $TEST_DIR_2
chown u1 $TEST_DIR_2
chmod a=rwx $TEST_DIR_2
chmod +t $TEST_DIR_2

#16
cp /bin/nano $TEST_DIR_2/nano
chown u1 $TEST_DIR_2/nano
chmod a=x,u+s $TEST_DIR_2/nano
