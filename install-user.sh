#!/bin/bash
echo ""
echo "welcome to installing user in Ubuntu"
echo "---------------------------------------"
echo ""
echo "Input yout Username here"
read username

echo ""
echo "check apt update"
apt update -y
echo ""
echo "installing sudo"
apt install sudo
echo ""
echo "create $username"
adduser $username
echo ""
echo "add $username to sudo group"
usermod -aG sudo $username
echo ""
echo "set $username"
cp /etc/sudoers /etc/sudoers.orginal
echo "$username	ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "Set disable_coredump false" >> /etc/sudo.conf
echo ""
echo "create hush login"
touch /home/$username/.hushlogin
echo ""
echo ""
clear
echo "completely!!!"
echo ""
echo ""

echo "Whats next??"
echo "- press \"exit\" here!"
echo "- backup \"./start-ubuntu.sh\""
echo "cp ./start-linux.sh ./start-linux.old"
echo "- edit using nano"
echo "nano ./start-linux.sh"
echo "- follow what i edit...:"
echo ""
echo "command+=\" -w /root\"  ->  command+=\" -w /home/$username\""
echo "command+=\" HOME=/root\"  ->. command+=\" HOME=/home/$username\""
echo "command+=\" /bin/bash --login\"  ->  command+=\"bin/su - billy1 -s /bin/bash\""
echo ""
echo "- Save (Ctrl + S) and exit (Ctrl + X)"