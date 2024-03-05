mysql_root_password=$1

echo Disable default NodeJS Version Module
dnf module disable nodejs -y  &>>/tmp/expense.log
echo $?

echo enable NodeJS  Module for V20
dnf module enable nodejs:20 -y  &>>/tmp/expense.log
echo $?

echo Install NodeJS
dnf install nodejs -y  &>>/tmp/expense.log
echo $?

echo Adding Application user
useradd expense &>>/tmp/expense.log
echo $?

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service  &>>/tmp/expense.log
echo $?

echo clean the old content
rm -rf /app  &>>/tmp/expense.log
echo $?

echo create App Directory
mkdir /app  &>>/tmp/expense.log
echo $?

echo Download app content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

echo extract app content
cd /app  &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

echo Download NodeJS Dependencies
cd /app  &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

echo start backend servic
systemctl daemon-reload  &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?

echo install MYSQL client
dnf install mysql -y  &>>/tmp/expense.log
echo $?

echo Load schema
mysql -h 172.31.16.209 -uroot -p${mysql_root_password} < /app/schema/backend.sql  &>>/tmp/expense.log
echo $?
