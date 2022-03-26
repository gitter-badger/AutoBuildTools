#/bin/bash

# source_path = /home/pi/ip_report

# sleep 15        # Waiting for the system to start

# cd $source_path

uname -n > ip.txt

echo "\r\n"

ifconfig >> ip.txt

python3 autoemail.py
