#!/bin/bash
sudo su
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
cd /var/www/html
wget https://github.com/azeezsalu/techmax/archive/refs/heads/main.zip
unzip main.zip
cp -r techmax-main/* /var/www/html/
rm -rf techmax-main main.zip
systemctl start httpd.service
systemctl enable httpd.service





# # Install cloudwatch agent and send logs to the cloudwatch log group
# sudo yum install awslogs -y
# sudo sed -i "s/.*region = us-east-1/region = eu-west-1/g" /etc/awslogs/awscli.conf
# sudo sed -i "s/.*file = \/var\/log\/messages/file = \/var\/log\/httpd\/access_log/g" /etc/awslogs/awslogs.conf
# sudo service awslogsd start
# sudo systemctl  enable awslogsd

