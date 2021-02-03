#!/bin/bash

#Problem Statement:
#Create a utility which will - 
#       - Add NinjaTeam (Simulate Group) 
#       - Add a User (Simulate) under a team 
#       - Assign user to another team 
#Ensure below constraints are met: 
#       - A user should have read,write, execute access to home directory 
#       - All the users of same team should have read and excute access to home directory of fellow team members 
#       - Other team members should not have any access to other team members directory 
#       - In home directory of every user there should be 3 shared directories 
#               - team: Same team members will have full access 
#               - ninja: All ninja's will have full access 
#               - all: Every in the system should have full access.

# List of Arguments Received
operation=$1
para1=$2
para2=$3

# Functions
function addTeam(){
team_name=$1
        echo -e "\e[1;33m Added group $1\e[0m"
        sudo groupadd -f $team_name
        sudo cat /etc/group | grep $team_name
}
function print_directoryStructure(){
echo -e "\e[1;31m Printing the Directory Structure \e[0m"
path="/home/$1"
cd $path
ls -lh
}
function createDefaultDirectorys(){
usr_name=$1
gpr_name=$2
dir_ninja='ninja'
dir_team=$gpr_name
dir_all='all'
grp_all='all'
hom_dir='home'
# create directories and give the relevant permissions
        echo -e "\e[1;31m Creating Required Directories and Structure\e[0m"
        cd /$hom_dir/
        sudo mkdir -p $usr_name/
        cd /$hom_dir/$usr_name/

        sudo mkdir -p $dir_all
        sudo chgrp $grp_all $dir_all
        sudo chmod 777 $grp_all

        sudo mkdir -p $dir_ninja

        sudo mkdir -p $dir_team
        sudo chmod g+rwx $dir_team
        sudo chgrp $gpr_name $dir_team
        echo -e "\e[1;31m Required Directories and Structure\e[0m"

print_directoryStructure $usr_name

}
function addUser(){
user_name=$1
group_name=$2
#Assumption that there is already a all group that has full access
full_access='all'
        if [ -z "$group_name" ]
        then
                echo -e "\e[1;31m Not created the user: $user_name as Group name is Missing\e[0m"
        else
                sudo useradd -G $group_name $user_name
                echo -e "\e[1;33m User Created: $user_name\e[0m"
                #sudo usermod -a -G $group_name $user_name
                echo -e "\e[1;33m User: $user_name add to Group: $group_name\e[0m"
                sudo usermod -a -G $full_access $user_name
                echo -e "\e[1;33m User: $user_name add to Group: $full_access\e[0m"
                sudo passwd $user_name
                echo -e "\e[1;33m User: $user_name and password updated\e[0m"
                sudo cat /etc/group | grep $user_name
                createDefaultDirectorys $user_name $group_name
        fi
}
function changeGroup(){
us_name=$para1
gp_name=$para2
        usermod -g $gp_name $us_name
}
# Fetch the user operation and perform accordingly
case "$operation" in
   "addTeam") 
   addTeam $para1
   ;;
   "addUser") 
   addUser $para1 $para2
   ;;
   "changeGroup") 
   changeGroup $para1 $para2
   ;;
   "$operation")
   echo "CMD: $operation not found."
esac