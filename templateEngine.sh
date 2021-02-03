#!/bin/bash --

#This is the code of the template engine
template_file_name=$1
key1=$2
key2=$3
template_location='/home/sid/lin_Learning/proc_files'
bkp_location='/home/sid/lin_Learning/proc_files/bkp'
delimeter_char_1='{'
delimeter_char_2='}'

function trimKeyValues(){
  key1=${key1:6}
  key2=${key2:6}
  #echo > /dev/null
}

# function to display key values
function printValues(){
  echo "Template file: $template_file_name "
  echo "Key 1: $key1"
  echo "Key 2: $key2"
  #echo $template_location
  #echo > /dev/null
}
function replaceKeys() {
  sed  -i 's/fname/'"$key1"'/g' ${template_file_name}
  sed  -i 's/topic/'"$key2"'/g' ${template_file_name}
}
function filecleanup() {
  cd $template_location
  #echo $template_location
  #echo $delimeter_char_1
  #echo $delimeter_char_2
  #sudo cp  $template_file_name $bkp_location/$template_file_name_bkp
  sed -i 's/'"$delimeter_char_1"'//g' $template_file_name
  sed -i 's/'"$delimeter_char_2"'//g' $template_file_name
}
function printFinalContent(){
  cd $template_location
  cat $template_file_name
}
function check_bkp(){
  cd $bkp_location
  ls=`ls $template_file_name`
  validate=`echo $?`
  if [ $validate -ne 0 ]
  then
    #echo "Making the Backup of the file"
    sudo cp  $template_location/$template_file_name $bkp_location/$template_file_name
  else
    #echo "Backup is already present"
    echo > /dev/null
  fi
}
replace_from_bkp(){
  cd $bkp_location
  sudo cp  $template_file_name $template_location/$template_file_name
  validate2=`echo $?`
  if [ $validate2 -eq 0 ]
  then
    #echo "Copied from Backup"
    echo > /dev/null
  else
    #echo "Coping failed"
    echo > /dev/null
  fi
}

function start(){
        cd $template_location
        #ls -ls $template_file_name
        check_bkp
        trimKeyValues
        #printValues
        filecleanup
        replaceKeys
        printFinalContent
        replace_from_bkp
}

start
#replaceKeys

#Sample String
#./templateEngine.sh trainer.template key1=sandeep key2=linux
#./templateEngine.sh trainer.template fname=sandeep topic=linux
#{{fname}} is trainer of {{topic}}
