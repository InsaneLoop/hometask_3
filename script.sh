#!/bin/bash 
#Оновлення пакетів
sudo yum update -y 
sudo yum install mc vim git httpd cronie -y 
sudo service httpd start 
sudo systemctl enable httpd 

echo '#!/bin/bash' >> /root/sysinfo.sh
#Виводить поточну дату
echo 'date >> /var/log/sysinfo' >> /root/sysinfo.sh
#Інформація про вхідні підключення
echo 'w >> /var/log/sysinfo'  >> /root/sysinfo.sh
#Інформація про використання пам`яті
echo 'free -m >> /var/log/sysinfo'  >> /root/sysinfo.sh
#Інформація про використання місця на диску
echo 'df -h >> /var/log/sysinfo'  >> /root/sysinfo.sh
#Інформацію про відкриті мережеві порти та програми
echo 'ss -tulpn >> /var/log/sysinfo'  >> /root/sysinfo.sh
#Ping до "ukr.net"
echo 'ping -c1 -w1 ukr.net >> /var/log/sysinfo'  >> /root/sysinfo.sh

echo 'find / -type f -perm -4000 -exec ls -l {} \; >> /var/log/sysinfo' >> /root/sysinfo.sh
 
#Робить скріпт можливим для запуску
chmod -v +x /root/sysinfo.sh &>/tmp/chmod.log 
#Sysinfo тепер запускається кожної хвилини з Понеділка по П`ятницю    
echo ' * * * * 1-5 root /root/sysinfo.sh' >> /etc/crontab 
 
sudo service crond restart

snap install amazon-ssm-agent --classic
systemctl start amazon-ssm-agent
systemctl enable amazon-ssm-agent