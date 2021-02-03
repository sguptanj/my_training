#!/bin/bash --
#-----------------------------------------------------
# @Date: Wed Jan 6 01:04:57 IST 2021
# @Author: SIDDHARTH GUPTA
# @Batch: Ninja Batch 9
# @Group: NinjaWarriors
#-----------------------------------------------------
# Problem Statement:
# Assignment Number - 12 Part -B
# Create another Jenkins job that takes a Linux package name as input and
# then installs it on the remote system.
# Make sure it should check first if the package is installed or not.
# Pseudo Logic:
# 1. Fetch the software package info from the user.
# 2. Check if the software package is installed or Not
# 3. If installed alert the user
# 4. If the software is not installed install it.
# 5. Show user the successful installation message.
#-----------------------------------------------------
#-------------->>CONFIGURATION FILES<<----------------
#-------------->>ENVIRONMENTAL VARIABLES<<----------------
#-----------------------------------------------------
#--------User Args
package_name=$1

#--------User Flags
checkPackageInstallStatus=false

# The function check if the software is already installed or not
packageStatus(){
  echo "Validating the package status"
  check1=`dpkg -s $package_name`
  validation1=`echo $?`
  if [ $validation1 -eq 0 ]
  then
      checkPackageInstallStatus=true
      echo -e "\e[1;31mERROR:Package Already Installed on the system\e[0m"
  else
      checkPackageInstallStatus=false
      echo -e "\e[1;32mSUCCESS:Initiated the package installtion on the system\e[0m"
  fi
}

# the function installs the software on the system
installPackage(){
  echo -e "\e[1;32mInstalling the $package_name package\e[0m"
  sudo -S apt install $package_name -y
}

# The start block of the code
start(){
  packageStatus
  if [[ $checkPackageInstallStatus == false ]]
  then
      installPackage
      echo -e "\e[1;35mSUCCESS:Installed the $package_name software package\e[0m"
  fi
}

#The starting point of the code
start

#Sample Execution:
#./otPackageInstaller.sh firefox
#./otPackageInstaller.sh atom
