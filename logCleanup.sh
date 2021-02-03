#!/bin/bash --

# This is the log clean up utility

# Psedo Apporach:
#1. The user runs the utilty  
#2. Utility looks for the log.conf file
#3. Reads the data from the log.conf file
#4. The format of the data in the log.conf file is Below
#        <LOG LOCATION> <SIZE> <TIME> <DELETE/BACK UP>
#        <LOG LOCATION>: It specifies the log location
#              <SIZE>/<AGE>: the log file selection parameter
#        <SIZE>: the min size (in kb) above which the log archival/deletion has to be done
#        <TIME>: the min time (in hours) above which the log archival/deletion has to be done
#        <DELETE/BACK UP>: the operation that user has to perform
#        /var/log/nginx/  40 kb 08:00


#location of the log confi file

CONF_DIR='/home/sid/lin_Learning/conf_files'
LOG_CONF_FILE='logdetail.conf'
OUTPUT_LOC='/home/sid/lin_Learning/output_files'
OUTPUT_FILE='logs_list.txt'
PREVIOUS_DAY_LOGS='pr_logs.txt'
CURRENT_DAY_LOGS='cur_logs.txt'
CONSOLIDATE_LOGS='consolidated.txt'
current_day=`date +"%d"`

function config_details {
  echo "Configuration location: $CONF_DIR"
  echo "Configuration File: $LOG_CONF_FILE"
}

function read_config {
    cd $CONF_DIR
    log_location=`awk '{print $1}' $LOG_CONF_FILE`
    log_size=`awk '{print $2}' $LOG_CONF_FILE`
    log_timestamp=`awk '{print $3}' $LOG_CONF_FILE`
    log_operation=`awk '{print $4}' $LOG_CONF_FILE`
    echo -e "\e[1;31mUser Entered Details: $log_location $log_size $log_timestamp $log_operation\e[0m"
}

function get_logfile_list(){
  cd $log_location
  #echo $OUTPUT_LOC/$OUTPUT_FILE and changes the time format to hours[by removing ':' ] and removes the first line
  sudo ls -l > $OUTPUT_LOC/$OUTPUT_FILE
  cd $OUTPUT_LOC
  sed -i 's/://' $OUTPUT_FILE
  sed -i '1d' $OUTPUT_FILE
}

function filter_valid_list(){
  cd $OUTPUT_LOC
  #echo "Filtering the valid logs files"
  #echo "Timestamp : $log_timestamp"
  # awk '$8 >= 0800 {print $9, $8}' logs_list.txt
  echo "------------------Previous Day Logs----------------------------"
  awk '$7 < '"$current_day"' {print $0 }' $OUTPUT_FILE
  awk '$7 < '"$current_day"' {print $9 }' $OUTPUT_FILE > $PREVIOUS_DAY_LOGS
  echo "---------------------------------------------------------------"
  echo "-----------------Current Day Before $log_timestamp HRS--------------------"
  awk '$7 == '"$current_day"' && $8 < '"$log_timestamp"' {print $0 }' $OUTPUT_FILE
  awk '$7 == '"$current_day"' && $8 < '"$log_timestamp"' {print $9 }' $OUTPUT_FILE > $CURRENT_DAY_LOGS
  echo "---------------------------------------------------------------"
  cat $PREVIOUS_DAY_LOGS $CURRENT_DAY_LOGS > $CONSOLIDATE_LOGS
}

function backUpOperation (){
  echo "Peforming Backup."
  zip_name=`date +"%d%m%Y"`
  archive_name="archived_AppLogs_$zip_name"
  cd $OUTPUT_LOC
  while read f_name; do
    cd $log_location
    sudo zip $archive_name $f_name
  done < $CONSOLIDATE_LOGS
}
function deleteOperation {
  echo "Performing Perge."
  cd $OUTPUT_LOC
  while read f_name; do
    cd $log_location
    sudo rm -rf $f_name
  done < $CONSOLIDATE_LOGS
}

function perform_action (){
  #echo $log_operation
  case $log_operation in
   'B')
      backUpOperation
      ;;
   'D')
      deleteOperation
      ;;
   $log_operation)
     echo -e "\e[1;31mInvalid User operation - [$log_operation]\e[0m"
     ;;
esac
}
function remove_dummyfiles(){
  cd $OUTPUT_LOC
  sudo rm -rf $CONSOLIDATE_LOGS
  sudo rm -rf $OUTPUT_FILE
}

# Ulitity start up block
start(){
    echo "----------------------------------------------"
    echo -e "Log Utility \e[1;33marchival\e[0m/\e[1;31mdeletion\e[0m utility started"
    echo "----------------------------------------------"
    #config_details
    read_config
    get_logfile_list
    filter_valid_list
    perform_action
    remove_dummyfiles
}

start


# Sample Output:
# ------------------Previous Day Logs----------------------------
#-rw-r--r-- 1 www-data root    0 Dec 22 1452 ninjaturtles-error.log
#-rw-r--r-- 1 root     root  912 Dec 22 1540 ninjawarriors-error.log.1
#---------------------------------------------------------------
#-----------------Current Day After 0800 HRS--------------------
#-rw-r--r-- 1 root     root 2276 Dec 23 1752 23122020.zip
#-rw-r----- 1 www-data adm   534 Dec 23 0941 access.log
#-rw-r--r-- 1 root     root 4704 Dec 23 1755 archived_AppLogs_23122020.zip
#-rw-r----- 1 www-data adm    63 Dec 23 0904 error.log
#-rw-r----- 1 www-data adm  1102 Dec 23 1243 ninjaturtles-access.log
#-rw-r----- 1 www-data adm  1714 Dec 23 1248 ninjawarriors-access.log
#-rw-r----- 1 www-data adm     0 Dec 23 0806 ninjawarriors-error.log
#---------------------------------------------------------------


# To create the custom logs:
#---------------------------------------------------------------
#sudo touch -d '22 November 2020 14:52' ninjaturtles-error.log
#sudo touch -d '22 November 2020 14:32' ninjawarriors-error.log.1
#sudo touch -d '22 December 2020 15:32' access.log
#sudo touch -d '22 December 2020 16:32' error.log
#sudo touch -d '22 December 2020 17:32' ninjaturtles-access.log
#sudo touch -d '22 December 2020 18:32' ninjawarriors-access.log
##sudo touch -d '22 December 2020 19:32' ninjawarriors-error.log
#sudo touch -d '23 December 2020 14:32' ninjawarriors-error.log.1
#sudo touch -d '23 December 2020 13:32' ninjawarriors-error.log.2
#sudo touch -d '23 December 2020 14:32' ninjawarriors-error.log.3
#sudo touch -d '23 December 2020 13:32' ninjawarriors-error.log.4
#sudo touch -d '23 December 2020 15:32' ninjawarriors-error.log.5
#sudo touch -d '23 December 2020 07:32' ninjawarriors-error.log.6
#sudo touch -d '23 December 2020 06:32' ninjawarriors-error.log.7
#sudo touch -d '23 December 2020 05:32' ninjawarriors-error.log.8

