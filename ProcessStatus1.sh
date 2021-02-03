#!/bin/bash --

# /home/cloud_user/Lin_Learning/Play/AppConfig
# /home/cloud_user/Lin_Learning/Play/AppConfig/processes.cfg
# Problem Statement:
# Create a utility to display below details about multiple process id.
#               - Command ran by process.
#               - Environment variables used by process.
#               - Any other relevant information you want to show.
# Important Notes:
#               * It should be executed by any user in the system.
#               * Information about process should be stored in some configuration file.
#               * In addition to priting output in the console the script should store output in a log file for individual process.
#               * Nightly log should be zipped and stored in /tmp folder for complete utility.


# Solution Apporach/ Psedo Code:
#               - To read the process from the configuration file (collection of pid).
#               - According to the process fetched extra the required deatils.
#               - Prepare a seprate file as per the process and stores its information.
#               - At the end run the nightly log code to backup the old logs.


# To read the process from the configration file.
# Go to the location of the configration file
# Open the file and read the contents of the file line by line (Assumption all processes are listed line by line) and perform operations
# The below are the location of the configration file and log files
config_location="/home/cloud_user/Lin_Learning/Play/AppConfig/processes.cfg"
location="/home/cloud_user/Lin_Learning/Play/AppConfig/"
log_location="/home/cloud_user/Lin_Learning/Play/AppLogs/"
#echo "Reading the processes from the CONFIG file: $config_location"
#cat /c/Users/Public/tmp/AppConfig/processes.cfg
processes_listed=`cat $config_location`
# Code for the file Archival - Psedo Code Approch
# Go to the log directory and fetch the list of all the files that are 1 day old and make a list of thoes files 
#

function dailyArchival(){
oldfilelist="OneDayOldFiles.txt"
ar_name=`date +"%d%m%Y"`
file_archival_name="archived_log_$ar_name.zip"
cd $log_location
find . -mmin +1 -type f -print > $oldfilelist
test3=`echo $?`
if [ $test3 -ne 0 ]
then
        echo -e "\e[1;31mNo Files to Archive\e[0m"
else
        oldFiles=$log_location$oldfilelist
        echo $oldFiles
        echo -e "\e[1;33m Archival Process Started\e[0m"
        contents=1
        while read doc_name; do
        var=$doc_name
        var=${var:2}
        zip $file_archival_name $var
        rm $var
        contents=`expr $contents + 1`
        done < $oldFiles
fi
}
# Function to print Environment variables
function printEnVar(){
f_name2="_procEnVarDetails"
cat /proc/$1/environ
test2=`echo $?`
#echo "$test"
if [ $test2 -ne 0 ]
then 
        echo -e "\e[1;31mIt seems that process $1 terminated and thus no Environment Variable details found"
        echo "It seems that process $1 terminated and thus no Environment Variable details found" > $log_location$1$f_name2.log
else
        cat /proc/$1/environ > $log_location$1$f_name2.log
fi
echo " "
echo " "
}
function procDetails(){
f_name1="_procDetails"
ps $1
test1=`echo $?`
if [ $test1 -ne 0 ]
then 
        echo -e "\e[1;31mIt seems that process $1 terminated and thus no Process details found \e[0m"
        echo "It seems that process $1 terminated and thus no Process details found" > $log_location$1$f_name1.log
else
        ps $1 > $log_location$1$f_name1.log
fi
echo " "
}

#file='/c/Users/Public/tmp/AppConfig/processes.cfg'   
process=1  
while read procs_info; do  
  
#Reading each line and performing the associated tasks with Process Ids
#echo -e "\e[1;33m Performing operation on Process$process : $procs_info\e[0m" 
echo -e "\e[1;33m Performing operation on Process ID-$process : $procs_info\n\e[0m"
procDetails $procs_info
echo -e "\e[1;33m Environment Variable of Process ID-$process : $procs_info\e[0m"
printEnVar $procs_info

process=`expr $process + 1`  
done < $config_location  

dailyArchival