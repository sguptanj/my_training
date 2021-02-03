#!/bin/bash --
#-----------------------------------------------------
# @Date: Wed Dec 30 22:54:57 IST 2020
# @Author: SIDDHARTH GUPTA
# @Batch: Ninja Batch 9
# @Group: NinjaWarriors
#-----------------------------------------------------
# Problem Statement:
# Assignment Number - 10
#
# Part - B
#- Create another shell script that will take a repository as input and check
#  if there are any changes in the repo or not.
#  In case of changes, it should write the diff to a file in /tmp/<repo_name>.
#  Make sure this script can run periodically to fetch the repository information.
#-----------------------------------------------------
#-------------->>CONFIGURATION FILES<<----------------
#-------------->>ENVIRONMENTAL VARIABLES<<----------------
#-----------------------------------------------------

# User Defined Constants
GIT_DIR='/home/sid'
FOLDER_NAME='snap'
TEST_REPO='test_repo'
TEMP='/tmp'
BRANCH='siddharth'
MASTER='origin'
DIFF_FILE='difference.txt'
REPOSITORY_NAME='linux-batch-9-solutions'

# User arguments
repo_url=$1

#
rm -rf $GIT_DIR/$FOLDER_NAME
mkdir $GIT_DIR/$FOLDER_NAME

#User Flags
cloneSuccessful=false

cloneRepo(){
  echo -e "\e[1;32mCloning GIT repository\e[0m"
  cd $GIT_DIR/$FOLDER_NAME
  git init
  git clone $repo_url
  check1=`echo $?`
  if [ $check1 -eq 0 ]; then
    cloneSuccessful=true
    else
    cloneSuccessful=false
  fi
}
compareDiff(){
  echo -e "\e[1;32mComparing the difference\e[0m"
  cd $TEMP
  rm -rf $TEST_REPO
  mkdir $TEST_REPO
  cd $GIT_DIR/$FOLDER_NAME/$REPOSITORY_NAME
  git diff $MASTER $BRANCH > $TEMP/$TEST_REPO/$DIFF_FILE
  echo -e "\e[1;32mDifference Stored in $TEMP/$TEST_REPO/$DIFF_FILE\e[0m"
}
setRemoteRepo(){
  echo -e "\e[1;32mRemote Repo Added\e[0m"
  cd $GIT_DIR/$FOLDER_NAME/
  git remote add origin $repo_url
}
checkoutUserBranch(){
  echo -e "\e[1;32mSwitched to the user branch\e[0m" 
  echo -e "\e[1;32mUser branch: $BRANCH checkout\e[0m"
  cd $GIT_DIR/$FOLDER_NAME/$REPOSITORY_NAME
  git checkout $BRANCH
}

# This is the start function
start(){
  cloneRepo
  if [ $cloneSuccessful == true ]; then
    setRemoteRepo
    checkoutUserBranch
    compareDiff
  else
    echo -e "\e[1;31mERROR: Git Clone not successful! Please check the Repository URL\e[0m"
  fi
}

# This is the start of the program
start

# Sample INput:
# ./vcsRepoPollar.sh git@gitlab.com:ot-devops-ninja/batch9/linux/linux-batch-9-solutions.git
# ./vcsRepoPollar.sh git@gitlab.com:ot-devops-ninja/batch9/linux/linux-batch-9-solutions.git