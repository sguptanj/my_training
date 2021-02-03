#!/bin/bash --
#-----------------------------------------------------
# @Date: Sun Jan 3 20:08:29 IST 2021
# @Author: SIDDHARTH GUPTA
# @Batch: Ninja Batch 9
# @Group: NinjaWarriors
#-----------------------------------------------------
# Problem Statement:
# Assignment Number - 11
# Enable a functionality in your local repository to not allow a commit
# if it does not follow the below condition.
# Example:-
# git commit -m "[JIRA-xxxx]:status=done"  valid
# git commit -m "[JIRA-xxxx]:status=inprogress" valid
# git commit -m "hello word" invalid
# git commit -m "fixed a issue" invalid
# git commit -m "fixed a UT bug" invalid
#-----------------------------------------------------
# Pseudo Logic:
# 1. Allow the user to enter the commit Message.
# 2. Fetch the commit message and store it in a file.
# 3. Check for the valid Giot Syntax
# 4. Check for the valid JIRA Ticket Syntax
# 5. Perform the commit operation if conditions in the step 2 and 3 are true
# 6. Show the status message of the operation
# 7. Delete the file in which the commit message was stored
#-----------------------------------------------------
#-------------->>CONFIGURATION FILES<<----------------
#-------------->>ENVIRONMENTAL VARIABLES<<----------------
#-----------------------------------------------------
#------------->>User Arguments<<----------------------
#message=$1
#-----------------------------------------------------
#------------->>User Defined Constants----------------
GIT_COMMIT_MSG_SYNTAX='git commit -m'
JIRA_TKT_SYNTAX='JIRA-'
MESSAGE_FILE='/home/sid/lin_Learning/proc_files/gitCommitMsg.txt'
#------------->>Condition Validation Flags<<----------
validGitSyntax=false
validJIRATktSyntax=false
#-----------------------------------------------------
# This block check if the essential git syntax is present or Not
# Example in commit message: git commit -m "hello word"
# git commit -m is the essential syntax
checkgitCommitSyntax(){
    check1=`grep "$GIT_COMMIT_MSG_SYNTAX" "$MESSAGE_FILE"`
    validation1=`echo $?`
    if [ $validation1 -eq 0 ]
    then
        validGitSyntax=true
        echo -e "\e[1;32mValid GIT Syntax\e[0m"
    else
        validGitSyntax=false
        echo -e "\e[1;31mIn-valid GIT Syntax\e[0m"
    fi
}
saveUserMessageToFile(){
  sudo echo $message > $MESSAGE_FILE
}
checkJIRATicketNumberSyntax(){
  check2=`grep "$JIRA_TKT_SYNTAX" "$MESSAGE_FILE"`
  validation2=`echo $?`
  if [ $validation2 -eq 0 ]
  then
      validJIRATktSyntax=true
      echo -e "\e[1;32mValid JIRA TICKET Syntax\e[0m"
  else
      validJIRATktSyntax=false
      echo -e "\e[1;31mIn-valid JIRA TICKET Syntax\e[0m"
  fi
}
validateCommitMessage(){
  echo "Validating the commit message...."
  checkgitCommitSyntax
  checkJIRATicketNumberSyntax
}
performCommit(){
  echo "Valid Commit Message"
}
delUserMessageFile(){
  sudo rm -rf $MESSAGE_FILE
}
start(){
  echo "Please enter a commit message below: "
  read message
  saveUserMessageToFile
  validateCommitMessage
  if [[ $validGitSyntax == true  && $validJIRATktSyntax == true ]]
  then
      performCommit
      echo -e "\e[1;35mSUCCESS:Processed the User Commit Operation\e[0m"
  else
      echo -e "\e[1;31mERROR: Invalid Commit Message Specified\e[0m"
  fi
  delUserMessageFile
}
#The starting point of the code
start
