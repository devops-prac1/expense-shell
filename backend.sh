source common.sh

mysql_root_password=$1

# if password is not provided then we will exit
if [ -z "${mysql_root_password}" ]; then
  echo input password is mising.
  exit 1
fi




 print_Task_Heading "Disable default NodeJS Version Module"
dnf module disable nodejs -y  &>>$LOG
check_status $?


print_Task_Heading  "enable NodeJS  Module for V20"
dnf module enable nodejs:20 -y  &>>$LOG
check_status $?

print_Task_Heading "Install NodeJS"
dnf install nodejs -y  &>>$LOG
check_status $?

print_Task_Heading "Adding Application user"
useradd expense &>>$LOG
check_status $?

print_Task_Heading "copy backend service file"
cp backend.service /etc/systemd/system/backend.service  &>>$LOG
check_status $?

print_Task_Heading "clean the old content"
rm -rf /app  &>>$LOG
check_status $?

print_Task_Heading "create App Directory"
mkdir /app  &>>$LOG
check_status $?

print_Task_Heading "Download app content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
check_status $?

print_Task_Heading "extract app content"
cd /app  &>>$LOG
unzip /tmp/backend.zip &>>$LOG
check_status $?

print_Task_Heading  "Download NodeJS Dependencies"
cd /app  &>>$LOG
npm install &>>$LOG
check_status $?

print_Task_Heading  "start backend service"
systemctl daemon-reload  &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
check_status $?

print_Task_Heading "install MYSQL client"
dnf install mysql -y  &>>$LOG
check_status $?

print_Task_Heading "Load schema"
mysql -h 172.31.16.209 -uroot -p${mysql_root_password} < /app/schema/backend.sql  &>>$LOG
check_status $?