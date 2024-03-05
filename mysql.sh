source common.sh

print_Task_Heading "Install Nginx"
dnf install mysql-server -y  &>>$LOG
check_status $?

print_Task_Heading "Install Nginx"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
check_status $?


print_Task_Heading "Install Nginx"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG
check_status $?