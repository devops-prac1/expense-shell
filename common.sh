print_Task_Heading(){
  echo $1
  LOG=/home/ec2-user/expense-shell/TMP.log
  echo "########   $1 ################" &>>$LOG
}
check_status() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
  fi
}