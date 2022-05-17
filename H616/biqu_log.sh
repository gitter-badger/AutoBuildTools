#!/bin/bash

home_dir=Hurakan

new_username=BIQU-Hurakan
old_username=orangepi

hostname=Hurakan

usermod -l $new_username $old_username
usermod -d /home/$homepath -m $new_username
groupmod -n $new_username $old_username
usermod -u 1000 $new_username

id $new_username        # check log

