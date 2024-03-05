source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo input password is missing
  exit 1
 fi


print_Task_Heading "Install Nginx"
dnf install mysql-server -y  &>>$LOG
check_status $?

print_Task_Heading "Install Nginx"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
check_status $?


print_Task_Heading "Install Nginx"
mysql_secure_installation --set-root-pass  ${mysql_root_password} &>>$LOG
check_status $?