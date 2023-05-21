#!/bin/bash
for all in $(dpkg --get-selections | awk '{print $1}')
do
  sudo apt-mark hold $all
done