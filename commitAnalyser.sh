#!/bin/bash --
#-----------------------------------------------------
# @Date: Wed Dec 30 19:28:14 IST 2020
# @Author: SIDDHARTH GUPTA
# @Batch: Ninja Batch 9
# @Group: NinjaWarriors
#-----------------------------------------------------
# Problem Statement:
# Assignment Number - 10
#
# Part - A
#- Create a shell script in which we can pass the days as a parameter so
#  that it can perform these operations:-
#           - It should generate a terminal output of Author Name, Author Email,
#              Commit ID, File Name, Date and make sure it should fetch the details
#               for respective days which we have given as input.
#           - Add HTML output capability to the shell script to generate an
#               HTML report.
#-----------------------------------------------------
#-------------->>CONFIGURATION FILES<<----------------
#-------------->>ENVIRONMENTAL VARIABLES<<----------------
#-----------------------------------------------------

# User Defined Constants
GIT_DIR='/home/sid/remoteCodeBase/linux-batch-9-solutions'
OUTPUT_LOC='/home/sid/lin_Learning/proc_files'
ARTIFACT_HTML='result.html'
SELECTED_COMMITS='required_commits.txt'
REGEX='^[0-9]'

# User Arguments
day=$1

# Code Flags
dayValidArg=false

# Fetch the user input
fetchUserInput(){
  resultant_day=`expr $day + 1`
  echo "Fetching the commit of last $day days"
}

# Validates if the user input
validateUserInput(){
  check1=`echo $day | egrep -q "$REGEX"`
  checkStatus=`echo $?`
  #echo $checkStatus
  if [ $checkStatus -eq 0 ]; then
    dayValidArg=true
    else
      dayValidArg=false
    fi
}

# Converting the no of day to date
converingDayToDate(){
  current_date=`date +"%Y/%m/%d"`
  #echo "The current date is: $current_date"
  required_date=$(date -d "$date - $resultant_day days" +"%Y/%m/%d")
  #echo "Fetching the commits after : $required_date"
  #echo $required_date
  formated_required_date=$(date -d "$date - $day days" +"%d/%m/%Y")
  #echo $formated_required_date
}

# The function fetches commits based on the search condition
fetchcommits(){
  cd $GIT_DIR
  #echo  $required_date
  git log --after $required_date --reverse >> $OUTPUT_LOC/$SELECTED_COMMITS
}

# The function generates a basic HTML skeleton and put the
# commits info inside
generateHTML_Doc(){
   cd $OUTPUT_LOC
   rm -rf $ARTIFACT_HTML
   touch $ARTIFACT_HTML
   echo "<HTML>" >> result.html
   echo "<HEAD>" >> result.html
   echo "<TITLE>Commit Logs</TITLE>" >> result.html
   echo "</HEAD>" >> result.html
   echo "<BODY>" >> result.html
   echo "<H1> Commit Logs: </H1>" >> result.html
   echo "<H3>Searching the logs for last <a style="color:red"> $day </a> days  </H3>" >> result.html
   #echo "$ps" >> result.html
   echo "<H2>The below logs are from <a style="color:red"> $formated_required_date </a> and onwards</H2>" >> result.html
   echo "<PRE>" >> result.html
   #echo $log_captured >> result.html
   cat required_commits.txt >> result.html
   echo "</PRE>" >> result.html
   echo "</BODY>" >> result.html
   echo "</HTML>" >> result.html
   rm -rf $SELECTED_COMMITS
}

# The start block of the code
start(){
  validateUserInput
  if [ $dayValidArg == true ]; then
    fetchUserInput
    converingDayToDate
    fetchcommits
    generateHTML_Doc
    echo -e "\e[1;32mSUCCESS:Output File Generated at: $OUTPUT_LOC/$ARTIFACT_HTML\e[0m"
  else
    echo -e "\e[1;31mERROR:Invalid day argument used\e[0m"
  fi
}

# This is the start of the program
start

# Sample Input Syntax
#./<script_name> <days>
#./commitAnalyser.sh 5
