#!/bin/bash --

# Problem Statement:
# To create a utility to perform Directory and File Operations

# Fetching the user input arguments
#FileManager.sh addDir /c/Users/Public/tmp dir1
#./FileManager.sh showFileContentForLineRange /c/Users/Public/tmp/dir1 file1.txt 5 10
#echo $0
operation=$1
location=$2
name=$3
stcontent=$4
a5=$5

# Functions Definations
function addDirectory(){
	mkdir -p "$location/$name"
}
function listFiles(){
	pattern='a'
	ls -lh $location | grep -e $patter
}
function listDirs(){
	ls -ltrh $location | grep  '/'
}
function listAll(){
	ls -lh "$location/"
}
function deleteDir(){
	rmdir -v $location/$name
}
function addNewFile(){
	cd $location
	touch $name
}
function contentToNewFile(){
	cd $location
	echo $stcontent > $name
}
function appendContentToFile(){
	cd $location
	echo $stcontent >> $name
}
function appendContentToBegFile(){
	cd $location
	echo -e "$stcontent\n$(cat $name)" > $name
}
function showFileBeginingContent(){
	cd $location
	head -$stcontent $name
}
function showFileEndContent(){
	cd $location
	tail -$stcontent $name
}
function showFileContentAtLine(){
	cd $location
	head -$stcontent $name | tail -1
}
function showFileContentForLineRange(){
	#$ awk 'NR==5, NR==10; NR==12 {exit}' file1.txt
	cd $location
}
function moveFile(){
	mv $location $name
}
function copyFile(){
	cp $location $name
}
function clearFileContent(){
	cd $location
	echo "" > $name
}
function deleteFile(){
	cd $location
	rm $name
}

# File Operations and disk operations
# Adding a directory to a defined location
if [ $operation == "addDir" ]
then
    echo "Adding a Directory"
	addDirectory
fi
# Listing of file in a given directory
if [ $operation == "listFiles" ]
then
    echo "Listing the file inside the Directory"
	listFiles
fi
if [ $operation == "listDirs" ]
then
    echo "Listing the Sub-directory inside the Directory"
	listDirs
fi
if [ $operation == "listAll" ]
then
    echo "Listing all the Directory contents"
	listAll
fi

if [ $operation == "deleteDir" ]
then
    echo "Delete the Directory itself"
	deleteDir
fi
if [ $operation == "addFile" ]
then
	#Checking the null value here 
	if [ -z "$stcontent" ]
	then
		echo "Adding a file to a Directory"
		addNewFile
	else 
		echo "Adding the conent to a File"
		contentToNewFile
	fi
fi
if [ $operation == "addContentToFile" ]
then
    echo "Appending additional conent to the file."
	appendContentToFile
fi

if [ $operation == "addContentToFileBegining" ]
then
    echo "Appending additional conent to begining of file."
	appendContentToBegFile
fi

if [ $operation == "showFileBeginingContent" ]
then
    echo "Please find the contents from the begining of the file."
	showFileBeginingContent
fi

if [ $operation == "showFileEndContent" ]
then
    echo "Please find the contents from the begining of the file."
	showFileEndContent
fi

if [ $operation == "showFileContentAtLine" ]
then
    echo "Please find the contents at the specified line."
	showFileContentAtLine
fi

if [ $operation == "showFileContentForLineRange" ]
then
    echo "Please find the contents at the line ranges specified."
	showFileContentForLineRange
fi

if [ $operation == "moveFile" ]
then
    echo "Moving the file to desired location."
	moveFile
fi


if [ $operation == "copyFile" ]
then
    echo "Coping the file."
	copyFile
fi


if [ $operation == "clearFileContent" ]
then
    echo "Erasing the conent of the file."
	clearFileContent
fi

if [ $operation == "deleteFile" ]
then
    echo "Deleting the file."
	deleteFile
fi

#Test Case
#echo "User selectde $operation on $location $name, $stcontent"
# ./FileManager.sh addDir /tmp dir1
