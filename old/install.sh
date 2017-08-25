#! /bin/bash

path=~/.adapter

mkdir -p $path
cp -r . $path/

home=$HOME
user=$USER

os=$(cat /etc/os-release | grep ID= | grep -v VERSION | cut -d '=' -f2)
if [ "$os" == "manjaro" ]
	then
	sudo pacman -S python3 python-pip python-wheel python-pyqt5 tk --needed
	sudo pip3 install datetime
	sudo pip3 install Pillow
	sudo pip3 install matplotlib
	sudo pip3 install PySerial
	sudo pip3 install shutil
else
	echo 'Distrubutie niet gevonden.'
	echo 'Gelieven de volgende packatten te installeren voor python3:'
	echo ' - datetime'
	echo ' - os'
	echo ' - sys'
	echo ' - PyQt5'
	echo ' - matplotlib'
	echo ' - PySerial'
fi

chmod +x $path/gui.desktop

sudo sh -c "echo @reboot python3 $home/.adapter/data.py > /var/spool/cron/$user"
ln -sf $path/gui.desktop $(xdg-user-dir DESKTOP)/battery-monitor.desktop
sudo ln -sf $path/gui.desktop /usr/share/applications/
sudo ln -sf $path/gui.py /usr/local/bin/battery-monitor
bash $path/.adapter/update.sh