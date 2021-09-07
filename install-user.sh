#!/bin/bash
clear
echo ""
echo "welcome to installing user in Ubuntu"
echo "---------------------------------------"
echo ""
echo "Input your Username here"
read username

if [[ $username =~ ^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$ ]] ; then
  echo "Continue using bad username? (Press \"y\" for continue)"
read confirm
if [[ ! $confirm =~ ^(y|Y)$ ]] ; then
echo "Fail by bad name!"
exit
fi
fi

echo "add your password:"
read -s password
echo "confirm password:"
read -s confirm

if [ "$password" != "$confirm" ]
then
echo "Fail by password not couple!"
exit
fi

echo ""
echo "check apt update"
apt update -y
echo ""
echo "installing sudo"
apt install sudo
echo ""
echo "create $username"
echo -e "$password\n$password\n\n\n\n\n\ny" | adduser $username
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
echo "creating new start linux"
echo ""

folder=ubuntu-fs
bin=ustart.sh
echo "writing launch script"
cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A ubuntu-binds)" ]; then
    for f in ubuntu-binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b ubuntu-fs/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to / 
#command+=" -b /sdcard"
command+=" -w /home/$username"
command+=" /usr/bin/env -i"
command+=" HOME=/home/$username"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" su - $username -s /bin/bash"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

echo ""
clear
echo "completely!!!"
echo ""
echo ""

echo "Whats next??"
echo "- press \"exit\" here!"
echo "- run this command"
echo ""
echo "wget https://raw.githubusercontent.com/dinastishitpost/script/main/post.sh && bash post.sh && rm ./post.sh"
