source common.sh

app_dir=/usr/share/nginx/html
component=frontend

print_Task_Heading "Install Nginx"
dnf install nginx -y  &>>$LOG
check_status $?

print_Task_Heading "copy expense nginx configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
check_status $?

App_preReq

print_Task_Heading "start  Nginx service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?