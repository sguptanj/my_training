#!/bin/bash --
#-----------------------------------------------------
# @Date: Fri Dec 25 13:30:56 IST 2020
# @Author: SIDDHARTH GUPTA
# @Batch: Ninja Batch 9
# @Group: NinjaWarriors
#-----------------------------------------------------
#  Format of the process.txt file
# <PID> <USER> <PR><NI><VIRT><RES><SHR> <S>  <%CPU> <%MEM><TIME+> <COMMAND>
#   1      2    3    4   5    6    7     8     9     10     11       12
#-----------------------------------------------------
#Directory details
PROC_LOC='/home/sid/lin_Learning/proc_files'
PROCESS_LIST_FILE='process.txt'
TEMP_FILE='temp.txt'
#User Arguments
TEMP_FILE2='temp2.txt'
argument1=$1
argument2=$2
argument3=$3

#defined parameter
bottom='tail'
top='head'

#Flags
validOperation=false
operationExecutionStatus=false

generateAllProcessList(){
  cd $PROC_LOC
  top -b -n 1 > $PROC_LOC/$PROCESS_LIST_FILE
  # Format of the process.txt file
  # <PID> <USER> <PR><NI><VIRT><RES><SHR> <S>  <%CPU> <%MEM><TIME+> <COMMAND>
  #   1      2    3    4   5    6    7     8     9     10     11       12
  # triming the irrelevant details - 1-6 line of the file
  sudo sed -i '1,6d' $PROCESS_LIST_FILE
}
generateSubProcessList(){
  index=$1
  fun=$2
  processes=$3
  awk 'NR!=1{print $0}' $PROCESS_LIST_FILE | sort -k$index | $fun -$processes > $TEMP_FILE
}
printProcessValues(){
  count=$1
  while [ $count -ne 0 ]
  do
    sed -n  ${count}p $TEMP_FILE
    count=`expr $count - 1`
  done
}
delFiles(){
  cd $PROC_LOC
  rm -rf $TEMP_FILE $TEMP_FILE2
}

topProcess(){
  no_of_process=$1
  search_type=$2
  op_performed=0
  memory_index=10
  cd $PROC_LOC
  #echo $PROC_HEADER
  if [ $search_type == 'cpu' ]
  then
    operationExecutionStatus=true
    op_performed=1
    no_of_process=`expr $1 + 1`
    head -$no_of_process $PROCESS_LIST_FILE
  fi
  if [ $search_type == 'memory' ]
  then
    operationExecutionStatus=true
    op_performed=1
    generateSubProcessList $memory_index $bottom $no_of_process
    sed -n 1p $PROCESS_LIST_FILE
    printProcessValues $no_of_process
    delFiles
  fi
  if [[ $op_performed -ne 1 ]]
  then
    operationExecutionStatus=false
  fi
}

killLeastPriorityProcess(){
  priority_index=4
  oneprocess=1
  operationExecutionStatus=true
  generateSubProcessList $priority_index $bottom $oneprocess
  sed -n 1p $PROCESS_LIST_FILE
  printProcessValues $oneprocess
  cd $PROC_LOC
  process_id=`awk '{print $1}' $TEMP_FILE`
  sudo kill -9 $process_id
}

RunningDurationProcess(){
  ps=$argument2
  reg_ex='^[0-9]+$'
  cd $PROC_LOC
  if [[ $ps =~ $reg_ex ]]
  then
      operationExecutionStatus=true
      echo "Process Id Entered: $ps"
      sed -n 1p $PROCESS_LIST_FILE
      cat $PROCESS_LIST_FILE | grep $ps
   else
     operationExecutionStatus=true
     echo "Process Name Entered: $ps"
     ps_name=`pidof $ps`
     sed -n 1p $PROCESS_LIST_FILE
     cat $PROCESS_LIST_FILE | grep "$ps_name"
    fi
}

listZoombieProcess(){
  delFiles
  cd $PROC_LOC
  sudo ps aux | grep 'Z' > $TEMP_FILE
  awk '{print $1, $2, $3, $4, $5, $8, $11}' $TEMP_FILE > $TEMP_FILE2
  cat $TEMP_FILE2
  operationExecutionStatus=true
}
listOrphanProcess(){
  delFiles
  cd $PROC_LOC
  ps -elf | head -1; ps -elf | awk '{if ($5 == 1 && $3 != "root") {print $0}}' | head >$TEMP_FILE
  cat $TEMP_FILE
  operationExecutionStatus=true
}
ListWaitingProcess(){
  cd $PROC_LOC
  operationExecutionStatus=true
  grep 'D' $PROCESS_LIST_FILE

}
killProcess(){
  ps1=$argument2
  reg_ex1='^[0-9]+$'
  cd $PROC_LOC
  if [[ $ps1 =~ $reg_ex1 ]]
  then
      operationExecutionStatus=true
      echo "Process Id Entered: $ps1"
      sudo kill -9 $ps1
   else
     operationExecutionStatus=true
     echo "Process Name Entered: $ps"
     ps_name=`pidof $ps`
     sudo kill -9 $ps1
    fi
}

validateArguments(){
  case "$argument1" in
    'topProcess')
    topProcess $argument2 $argument3
    validOperation=true
    ;;
    'killLeastPriorityProcess')
    RunningDurationProcess
    validOperation=true
    killLeastPriorityProcess
    ;;
    'RunningDurationProcess')
    validOperation=true
    ;;
    'listOrphanProcess')
    validOperation=true
    listOrphanProcess
    ;;
    'listZoombieProcess')
    validOperation=true
    listZoombieProcess
    ;;
    'killProcess')
    validOperation=true
    killProcess
    ;;
    'ListWaitingProcess')
    validOperation=true
    ListWaitingProcess
    ;;
    ''$argument1'')
     echo -e "\e[1;31mInvalid User operation - [$argument1]\e[0m"
     validOperation=false
     ;;
  esac

}

start(){
    generateAllProcessList
    validateArguments
    if [[ $validOperation == true && $operationExecutionStatus == true ]]
    then
      echo -e "\e[1;33mSUCCESS:Processed the User Operation: $argument1\e[0m"
    else
      echo -e "\e[1;31mERROR: Invalid Arguments Used\e[0m"
    fi
}

#This the start function where the code actually begins
start

#./ otProcessManager topProcess 5 memory
# ./otProcessMgtUtility.sh topProcess 5 memory -- done

#./ otProcessManager topProcess 10 cpu
# ./otProcessMgtUtility.sh topProcess 5 cpu  -- done

#./ otProcessManager killLeastPriorityProcess
# ./otProcessMgtUtility.sh killLeastPriorityProcess  -- done

#./ otProcessManager RunningDurationProcess <processName>/<processID>
#./otProcessMgtUtility.sh RunningDurationProcess top  ---done
# ps - and put the bash id
#./otProcessMgtUtility.sh RunningDurationProcess top  --- done

#./ otProcessManager listOrphanProcess --- done
# ./otProcessMgtUtility.sh listOrphanProcess

#./ otProcessManager listZoombieProcess  --- done
#./otProcessMgtUtility.sh listZoombieProcess

#./ otProcessManager killProcess <processName>/<processID>  --done
#./otProcessMgtUtility.sh killProcess 41

#./ otProcessManager ListWaitingProcess  --done
#./otProcessMgtUtility.sh ListWaitingProcess
