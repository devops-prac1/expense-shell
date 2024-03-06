source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo input password is missing
  exit 1
 fi


print_Task_Heading "Install mysql server"
dnf install mysql-server -y  &>>$LOG
check_status $?

print_Task_Heading "start mysql service"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
check_status $?


print_Task_Heading "set up my sql password"
echo 'show databases' |mysql -h mysql-dev.priya9sdr.online -uroot -p${mysql_root_password}  &>>$LOG
if [ $? -ne 0 ]; then
mysql_secure_installation --set-root-pass  ${mysql_root_password} &>>$LOG
fi
check_status $?