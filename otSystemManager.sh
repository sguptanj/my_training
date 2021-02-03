#!/bin/bash --

# Search for the start function to track the code

# defining the constants
ENABLE_PASS_VALUE='PasswordAuthentication yes'
DISABLE_PASS_VALUE='PasswordAuthentication no'
SSH_CONFIG_FILE='/etc/ssh/sshd_config'
#SSH_CONFIG_FILE='/home/sid/lin_Learning/proc_files/test.txt'
ENABLE_KEY_VALUE='PubkeyAuthentication yes'
DISABLE_KEY_VALUE='PubkeyAuthentication no'
USER_MATCH_KEYWORD='Match User '
TIMEOUT_PARAMETER='ClientAliveCountMax'
ROOT_USER='root'
ROOT_GROUP='root'

# Fetching the user arguments
userOperation=$1
userName=$2
parameter=$3
operationValidFlag=false
operationExecutionFlag=false
userValidFlag=false

addUser(){
  sudo adduser $userName
  testaddUser=`echo $?`
  #echo "Validating: $testaddUser"
  if [[ $testaddUser -eq 0 ]]
  then
    echo -e "\e[1;32mUser[$userName] Added \e[0m"
    operationExecutionFlag=true
  else
    echo -e "\e[1;31mERROR: User[$userName] Not Added \e[0m"
  fi
}
addUserToGroup(){
  groupName=$1
  sudo usermod -a -G $groupName $userName
  testsgroupAdd=`echo $?`
  #echo "Validating: $testaddUser"
  if [[ $testsgroupAdd -eq 0 ]]
  then
    echo -e "\e[1;32mUser[$userName] Added to Group[$groupName]  \e[0m"
    operationExecutionFlag=true
  else
    echo -e "\e[1;31mERROR: User[$userName] Not Added to Group[$groupName] \e[0m"
  fi
}
updatePrimaryGroup(){
    grpName=$1
    sudo usermod -g $grpName $userName
    testpgroupAdd=`echo $?`
    #echo "Validating: $testaddUser"
    if [[ $testpgroupAdd -eq 0 ]]
    then
      echo -e "\e[1;32mUser[$userName] Added to Primary Group[$groupName]  \e[0m"
      operationExecutionFlag=true
    else
      echo -e "\e[1;31mERROR: User[$userName] Not Added to Primary Group[$groupName] \e[0m"
    fi
}

checkUserEntry(){
  keyMatch="$USER_MATCH_KEYWORD $userName"
  keyMatch=`echo $keyMatch`
  chk=`grep -x "$keyMatch" "$SSH_CONFIG_FILE"`
  validateUser=`echo $?`
  if [[ $validateUser -eq 0 ]]
  then
    echo -e "\e[1;32mSUCCESS: User[$userName] Valid User \e[0m"
    userValidFlag=true
  else
    echo -e "\e[1;31mERROR: User[$userName] Invalid User \e[0m"
  fi
}

enablePasswordBasedLogin(){
    checkUserEntry
    if [[ $userValidFlag == true ]]
    then
    sudo sed -i 's/'"$DISABLE_PASS_VALUE"'/'"$ENABLE_PASS_VALUE"'/' $SSH_CONFIG_FILE
    testpwdEnable=`echo $?`
    #echo "Validating: $testaddUser"
    if [[ $testpwdEnable -eq 0 ]]
    then
      echo -e "\e[1;32mUser[$userName] Enabled for Password Login  \e[0m"
      operationExecutionFlag=true
      sudo service sshd reload
    else
      echo -e "\e[1;31mERROR: User[$userName] Not Enabled for Password Login \e[0m"
    fi
    fi
}
disablePasswordBasedLogin(){
  checkUserEntry
  if [[ $userValidFlag == true ]]
  then
    sudo sed -i 's/'"$ENABLE_PASS_VALUE"'/'"$DISABLE_PASS_VALUE"'/' $SSH_CONFIG_FILE
    testpwdDisable=`echo $?`
    #echo "Validating: $testaddUser"
    if [[ $testpwdDisable -eq 0 ]]
    then
      echo -e "\e[1;32mUser[$userName] Disabled for Password Login  \e[0m"
      operationExecutionFlag=true
      sudo service sshd reload
    else
      echo -e "\e[1;31mERROR: User[$userName] Not Disabled for Password Login \e[0m"
    fi
  fi
}
enableKeyBasedLogin(){
  checkUserEntry
  if [[ $userValidFlag == true ]]
  then
    sudo sed -i 's/'"$DISABLE_KEY_VALUE"'/'"$ENABLE_KEY_VALUE"'/' $SSH_CONFIG_FILE
    testkeyEnabled=`echo $?`
    if [[ $testkeyEnabled -eq 0 ]]
    then
      echo -e "\e[1;32mUser[$userName] Enabled for Keybased Authorization  \e[0m"
      operationExecutionFlag=true
      sudo service sshd reload
    else
      echo -e "\e[1;31mERROR: User[$userName] Not Enabled for Keybased Authorization \e[0m"
    fi
  fi
}
disableKeyBasedLogin(){
  checkUserEntry
  if [[ $userValidFlag == true ]]
  then
    sudo sed -i 's/'"$ENABLE_KEY_VALUE"'/'"$DISABLE_KEY_VALUE"'/' $SSH_CONFIG_FILE
    testkeyDisabled=`echo $?`
    if [[ $testkeyDisabled -eq 0 ]]
    then
      echo -e "\e[1;32mUser[$userName] Disabled for Keybased Authorization  \e[0m"
      operationExecutionFlag=true
      sudo service sshd reload
    else
      echo -e "\e[1;31mERROR: User[$userName] Not Disabled for Keybased Authorization \e[0m"
    fi
  fi
}
validate_UserName(){
  #Custom Flags
  usr_name=$1
  validateFlagUserName=false
  id $usr_name  > /dev/null 2>&1
  usrValidator=`echo $?`
  if [[ $usrValidator -eq 0 ]]
  then
    validateFlagUserName=true
    #echo "Valid User"
  else
    validateFlagUserName=false
    #echo "IN-valid User"
  fi
}
validate_UserDirectory(){
  #Custom Flags
  validateDirectory=false
  #Validate directory
  dir_location=$1
  cd $dir_location
  dirValidator=`echo $?`
  if [[ $dirValidator -eq 0 ]]
  then
    validateDirectory=true
    #echo "Valid Dir"
  else
    validateDirectory=false
    #echo "Invalid Dir"
  fi
}
restrictUserToDir(){
  validate_UserDirectory $parameter
  validate_UserName $userName
  if [[ $validateFlagUserName == true  && $validateDirectory == true ]]
  then
    operationExecutionFlag=true
    sudo chown -R $ROOT_USER:$ROOT_GROUP $parameter
    echo -e "\e[1;31mRESTRICTED ACCESS SUCCESSFUL\e[0m: For User $userName on Directory $parameter"
  else
    operationExecutionFlag=falses
    echo -e "\e[1;31mRESTRICTED ACCESS UN-SUCCESSFUL\e[0m: For User $userName on Directory $parameter"
  fi
}
disableRestrictUserToDir(){
  validate_UserDirectory $parameter
  validate_UserName $userName
  if [[ $validateFlagUserName == true  && $validateDirectory == true ]]
  then
    operationExecutionFlag=true
    sudo chown -R $userName:$userName $parameter
    echo -e "\e[1;32mDISABLED RESTRICTED ACCESS SUCCESSFUL\e[0m: For User $userName on Directory $parameter"
  else
    operationExecutionFlag=false
    echo -e "\e[1;31mDISABLED RESTRICTED ACCESS UN-SUCCESSFUL\e[0m: For User $userName on Directory $parameter"
  fi
}
setConnectionTimeout(){
  validate_UserName $userName
  timeoutInMin=$parameter
  checkUserEntry
  if [[ $validateFlagUserName == true && $userValidFlag == true ]]
  then
    operationExecutionFlag=true
    sudo sed -i 's/'"$TIMEOUT_PARAMETER"'/#'"$TIMEOUT_PARAMETER"'/g' $SSH_CONFIG_FILE
    sudo echo $TIMEOUT_PARAMETER $timeoutInMin >> $SSH_CONFIG_FILE
    echo -e "\e[1;32mCONNECTION TIMEOUT SUCCESSFUL\e[0m: For User $userName for $parameter minutes"
  else
    operationExecutionFlag=false
    echo -e "\e[1;31mCONNECTION TIMEOUT UN-SUCCESSFUL\e[0m: For User $userName for $parameter minutes"
  fi
}
validateUserOperation(){
  case "$userOperation" in
    'addUser')
    addUser
    operationValidFlag=true
    ;;
    'addUserToGroup')
    addUserToGroup $parameter
    operationValidFlag=true
    ;;
    'updatePrimaryGroup')
    updatePrimaryGroup $parameter
    operationValidFlag=true
    ;;
    'enablePasswordBasedLogin')
    enablePasswordBasedLogin
    operationValidFlag=true
    ;;
    'disablePasswordBasedLogin')
    disablePasswordBasedLogin
    operationValidFlag=true
    ;;
    'enableKeyBasedLogin')
    enableKeyBasedLogin
    operationValidFlag=true
    ;;
    'disableKeyBasedLogin')
    disableKeyBasedLogin
    operationValidFlag=true
    ;;
    'restrictUserToDir')
    restrictUserToDir
    operationValidFlag=true
    ;;
    'disableRestrictUserToDir')
    disableRestrictUserToDir
    operationValidFlag=true
    ;;
    'setConnectionTimeout')
     setConnectionTimeout
     operationValidFlag=true
     ;;
     '$userOperation')
     echo -e "\e[1;31mInvalid User operation - [$userOperation]\e[0"
     operationValidFlag=false
     ;;
   esac
}

start(){
      validateUserOperation
      #echo "$operationValidFlag"
      if [[ $operationValidFlag == true  && $operationExecutionFlag == true ]]
      then
          echo -e "\e[1;35mProcessed the User Operation: $userOperation\e[0m"
      else
          echo -e "\e[1;31mERROR: Invalid Arguments Used\e[0m"
      fi
}

start

# Added the code for testing the user and teh user operation
#./otSystemManager addUser <user name>
#./otSystemManager.sh addUser rishabh --- done

#./otSystemManager addUserToGroup <user name> <group name>
# ./otSystemManager.sh addUserToGroup ris all --done

#./otSystemManager updatePrimaryGroup <user name> <group name>
# ./otSystemManager.sh updatePrimaryGroup rishabh all -- done

#./otSystemManager enablePasswordBasedLogin <user name>
#./otSystemManager.sh enablePasswordBasedLogin sftp_user -- done

#./otSystemManager disablePasswordBasedLogin <user name>
#./otSystemManager.sh disablePasswordBasedLogin ftp_user -- done

#./otSystemManager enableKeyBasedLogin <user name>
#./otSystemManager.sh enableKeyBasedLogin ftp_user -- done

#./otSystemManager disableKeyBasedLogin <user name>
#./otSystemManager.sh disableKeyBasedLogin ftp_user -- done

#<To complete - Currently Pending>
# Additional Development started on: Fri Jan  1 21:17:33 IST 2021
#
#./otSystemManager restrictUserToDir <user name> <directory>
#./otSystemManager.sh restrictUserToDir ftp_user /tmp-- done
#
#./otSystemManager.sh restrictUserToDir ftp_user /home/sid/lin_Learning/proc_files/bkp/

#./otSystemManager disableRestrictUserToDir <user name>
#./otSystemManager.sh disableRestrictUserToDir ftp_user /home/sid/lin_Learning/proc_files/bkp/

#[The below command needs the root access]
#./otSystemManager setConnectionTimeout <user name> <timeout in minute>
#./otSystemManager.sh setConnectionTimeout ftp_user 10

#User Details in /etc/ssh/sshd_config
# User: ftp_user, specific entries
#Match User ftp_user
#X11Forwarding no
#AllowTcpForwarding no
#PermitTTY no
#ForceCommand cvs server
#PasswordAuthentication yes
#PubkeyAuthentication yes
# Time-out value is calculated as ClientAliveInterval * ClientAliveCountMax
#ClientAliveInterval 60
#ClientAliveCountMax 1
