#!/bin/bash

SETUP=$(expect -c "
set timeout -1
spawn ambari-server setup
expect \"OK to continue [y\/n] (y)?\"
send \"y\r\"
expect \"Customize user account for ambari-server daemon [y\/n] (n)\"
send \"n\r\"
expect \"OK to continue [y\/n] (y)?\"
send \"y\r\"
expect \"Enter choice (1):\"
send \"1\r\"
expect \"Do you accept the Oracle Binary Code License Agreement [y\/n] (y)?\"
send \"y\r\"
expect \"Enable Ambari Server to download and install GPL Licensed LZO packages [y\/n] (n)?\"
send \"y\r\"
expect \"Enter advanced database configuration [y\/n] (n)?\"
send \"n\r\"
expect eof
")

echo "$SETUP"
