#!/bin/bash

if [ $EUID -ne 0 ]
	then
		echo "Please run this as root!" 
		exit 1
fi

echo "Welcome fellow laptop user"
echo "make sure you have yay installed"
sleep 2s
echo "This script will automatically set up your laptop to have a much higher battery life than before."
sleep 2s
clear
echo "First we are going to install some needed programs."
sleep 2s
clear
echo "TLP is a very popular battery life tool which makes optimization simple"
sleep 1s
pacman -S tlp
sleep 1s
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
systemctl enable tlp.service
sleep 1s
systemctl start tlp.service
sleep 1s
clear
echo "now we are going to be automatically setting up the configs"
sleep 2s
clear
echo "mv /etc/tlp.conf /etc/tlp.conf/old"
mv /etc/tlp.conf /etc/tlp.conf.old
sleep 2s
echo "cp config/tlp.conf /etc/tlp.conf"
cp configs/tlp.conf /etc/tlp.conf
sleep 5s
clear
echo "TLP has been successfully configured!"
sleep 4s
clear
echo "Now it's time to configure auto-cpufreq."
sleep 1s
echo "Auto-cpufreq is a tool which governs, and configures your CPU to only use the ammount of power it actually needs on battery life."
sleep 4s
clear
runuser -l $USER -c 'yay -S auto-cpufreq'
sleep 1s
systemctl enable auto-cpufreq
systemctl start autocpufreq
sleep 4s
clear
echo "renaming old auto-cpufreq config. Don't poop your pants if you get an error, this only renames existing configs"
mv /etc/auto-cpufreq.conf /etc/auto-cpufreq.conf.old
sleep 4s
echo "cp configs/auto-cpufreq.conf /etc"
cp configs/auto-cpufreq.conf /etc/auto-cpufreq.conf
sleep 4s
clear
echo "Battery life has been successfully configured!"
sleep 1s
chmod +x uninstall.sh
echo "run ./uninstall.sh to revert all changes."
sleep 2s
clear
echo "A reboot is needed,type 'y' to reboot now and 'n' to reboot later"
read YN

if [ $YN = "y" ]
  then
    reboot
fi

done
