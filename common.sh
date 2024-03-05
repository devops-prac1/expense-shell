print_Task_Heading(){
  echo $1
  echo "########   $1 ################" &>>/tmp/expense.log
}
check_status() {
  if [ $? -eq 0]: then
    echo success
  else
    echo failure
    fi
}