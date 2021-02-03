#!/bin/bash --
# Analysing the student marks from the test file

MARKS_FILE_LOCATION='/home/sid/lin_Learning/proc_files'
MARKS_FILE_NAME='student_marksdetails.txt'
NO_OF_SUBJECT=3

average(){
  #cd $MARKS_FILE_LOCATION
  sub1=$2
  sub2=$3
  sub3=$4
  sum=`expr $sub1 + $sub2 + $sub3`
  avg=`expr $sum / $NO_OF_SUBJECT`
  default_grade='K'
  grade=$default_grade
  if [ $avg -ge 80 ]
  then
      #echo "$avg Grade A"
      grade='A'
  elif [[ $avg -ge 60 && $avg -lt 80 ]]
  then
      #echo "$avg Grade B"
      grade='B'
  elif [[ $avg -ge 50 && $avg -lt 60 ]]
  then
      #echo "$avg Grade C"
      grade='C'
  else
    #echo "$avg FAIL"
    grade='FAIL'
  fi

  if [ $grade == 'FAIL' ]
  then
      echo -e "$@ \e[1;31m$grade\e[0m"
  else
      echo "$@ $grade"
  fi
}

processFileContents(){
  cd $MARKS_FILE_LOCATION
  counter=0
  while read std_details; do
    average $std_details
    counter=`expr $counter + 1`
  done < $MARKS_FILE_NAME
}

start()
{
  processFileContents
}
start
