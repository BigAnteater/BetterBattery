#!/bin/bash

if [ $EUID -ne 0 ]
	then
		echo "Please run this as root!" 
		exit 1
fi
echo "This program will uninstall all of your TLP and auto-cpufreq configs"
systemctl stop tlp
systemctl disable tlp
systemctl unmask systemd-rfkill.service
systemctl unmask systemd-rfkill.socket
rm -rf /etc/tlp.conf
mv /etc/tlp.conf.old /etc/tlp.conf
pacman -Rns tlp
pacman -Rns auto-cpufreq
rm -rf /etc/auto-cpufreq.conf
mv /etc/auto-cpufreq.conf.old /etc/auto-cpufreq.conf
sleep 2s
clear
echo "A reboot is needed, type 'y' to reboot now and 'n' to reboot later"
read REBOOT

if [ $REBOOT = "y" ]
  then
    reboot
fi

done
