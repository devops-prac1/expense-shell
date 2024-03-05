source common.sh


print_Task_Heading "Install Nginx"
dnf install nginx -y  &>>&LOG
check_status $?


print_Task_Heading "copy expense nginx configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>&LOG
check_status $?



print_Task_Heading "clean old content"
rm -rf /usr/share/nginx/html/* &>>&LOG
check_status $?



print_Task_Heading "download app content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>&LOG
check_status $?

print_Task_Heading "Extract app content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>&LOG
check_status $?

print_Task_Heading "start  Nginx service"
systemctl enable nginx &>>&LOG
systemctl restart nginx &>>&LOG
check_status $?