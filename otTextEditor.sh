#!/bin/bash

# Hard Coded file details
FILE_LOCATION='/home/sid/lin_Learning/proc_files'
FILE_NAME='testfile.txt'

user_operation=$1
# Input Arguments recived from the user
file_name=$2
file_string1=$3
file_string2=$4
file_string3=$5

#To validate the correct file is being referred
fileValidFlag=false

userInput(){
  echo "Operation: $user_operation"
  echo "Input File: $file_name"
  echo "String: $file_string1"
}

validateFile(){
    if [ $file_name == $FILE_NAME ]
    then
        #echo "Valid File"
        echo > /dev/null
        fileValidFlag=true
    else
        echo -e "\e[1;31mInvalid File Name. Default File name: $FILE_NAME\e[0m"
        echo -e "\e[1;31mDefault File location: $FILE_LOCATION\e[0m"
    fi
}
addLineTop(){
  cd $FILE_LOCATION
  sed -i '1i '"$file_string1"'' $file_name
  echo "$user_operation performed"
}
addLineBottom(){
  cd $FILE_LOCATION
  echo $file_string1 >> $file_name
  echo "$user_operation performed"
}
addLineAt(){
  cd $FILE_LOCATION
  sed -i ' '"$file_string1"' i '"$file_string2"' ' $file_name
  echo "$user_operation performed"
}
updateFirstWord(){
  cd $FILE_LOCATION
  sed -i "1 s/$file_string1/$file_string2/" $file_name
  echo "$user_operation performed"
}
updateAllWord(){
  cd $FILE_LOCATION
  sed -i "s/$file_string1/$file_string2/g" $file_name
  echo "$user_operation performed"
}
insertWord(){
  cd $FILE_LOCATION
  # Not implemented - need clarity
  echo "Not Implemented"
}
deleteLine(){
  if [ -z $file_string3 ]
  then
    cd $FILE_LOCATION
    sed -i $file_string1"d" $file_name
    echo "$user_operation performed"
  else
    cd $FILE_LOCATION
    # Not implemented - need clarity
    echo "Not Implemented"
  fi
}
start(){
  #userInput
  validateFile
  if [ $fileValidFlag ]
  then
    case "$user_operation" in
      "addLineTop")
      addLineTop
      ;;
      "addLineBottom")
      addLineBottom
      ;;
      "addLineAt")
      addLineAt
      ;;
      "updateFirstWord")
      updateFirstWord
      ;;
      "updateAllWord")
      updateAllWord
      ;;
      "insertWord")
      insertWord
      ;;
      "deleteLine")
      deleteLine
      ;;
      "$user_operation")
      echo -e "\e[1;31mInvalid User Operation: $user_operation\e[0m"
      ;;
    esac
  fi
}

start

#Sample Input
#./<script_name> <user_operation> <file_name> <string_to_enter>
#./otTextEditor.sh addLineTop testfile.txt "Hello World" -done
#./otTextEditor.sh addLineBottom testfile.txt "Hello World" -done
#./otTextEditor.sh addLineAt testfile.txt 5 "Gym is good" -done
#./otTextEditor.sh updateFirstWord testfile.txt abhay anoop -done
#./otTextEditor.sh updateAllWord testfile.txt abhay anoop - done
#./otTextEditor.sh insertWord testfile.txt abhay anoop is -not implemented*
#./otTextEditor.sh deleteLine testfile.txt 2 -done
#./otTextEditor.sh deleteLine testfile.txt 2 is -done
#./otTextEditor.sh addLineTop testfile.txt "Hello World" -not implemented
