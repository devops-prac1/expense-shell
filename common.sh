
 LOG=/tmp/expense.log

 print_Task_Heading(){
  echo $1

  echo "########   $1 ################" &>>$LOG
}
check_status() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
    exit 2
  fi
}
App_preReq()  {
  print_Task_Heading "clean the old content"
  rm -rf ${app_dir} &>>$LOG
  check_status $?

  print_Task_Heading "create App Directory"
  mkdir {app_dir} &>>$LOG
  check_status $?

  print_Task_Heading "Download app content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
  check_status $?

  print_Task_Heading "extract app content"
  cd  ${app_dir} &>>$LOG
  unzip /tmp/${component}.zip &>>$LOG
  check_status $?
}