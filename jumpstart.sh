#!/bin/bash

if [ $EUID -ne 0 ]
	then
		echo "Please run this as root!" 
		exit 1
fi


sudo pacman -Syu dialog
dialog --title 'Hello,' --msgbox 'This script will (hopefully) make the battery life on your laptop better' 20 50
dialog --title 'WARNING!' --msgbox 'MAKE SURE YOU USE ARCH LINUX AND HAVE YAY FOR THIS!' 20 50
dialog --msgbox 'This script will automatically set up your laptop to have a much higher battery life than before.' 20 50
clear
dialog --msgbox 'First we are going to install some needed programs.' 20 50
sleep 1s
dialog --msgbox  'TLP is a very popular battery life tool which makes optimization simple' 20 50
sleep 1s
pacman -Sy tlp -y
sleep 1s
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
systemctl enable tlp.service
sleep 1s
systemctl start tlp.service
sleep 1s
clear
dialog --msgbox 'Now we are going to be automatically setting up the configs, dont worry, this will back up your current config' 20 50
clear
mv /etc/tlp.conf /etc/tlp.conf.old
mv configs/tlp.conf /etc/tlp.conf
clear
dialog --msgbox 'TLP has been successfully configured!' 20 50
clear
dialog --msgbox 'Now its time to configure auto-cpufreq.' 20 50
dialog --msgbox 'Auto-cpufreq is a tool which governs, and configures your CPU to only use the ammount of power it actually needs on battery life.' 20 50
dialog --msgbox 'This will compile the program so it may take a while' 20 50
clear
runuser -l $USER -c 'yay -Sy auto-cpufreq'
sleep 1s
systemctl enable auto-cpufreq
systemctl start autocpufreq
sleep 4s
clear
dialog --msgbox 'Renaming old auto-cpufreq config. Dont poop your pants if you get an error, this only renames existing configs' 20 50
mv /etc/auto-cpufreq.conf /etc/auto-cpufreq.conf.old
sleep 1s
mv configs/auto-cpufreq.conf /etc/auto-cpufreq.conf
sleep 4s
clear
dialog --msgbox 'Battery life has been successfully configured!' 20 50
sleep 1s
chmod +x uninstall.sh
dialog --msgbox 'run ./uninstall.sh to revert all changes.' 20 50
sleep 2s
clear
echo "A reboot is needed,type 'y' to reboot now and 'n' to reboot later"
read YN

if [ $YN = "y" ]
  then
    reboot
fi

done
