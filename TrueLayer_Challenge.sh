#!/bin/bash
#Script created by Juanjo for the TrueLayer challenge.

#We declare the variables necessary for the correct execution of the script and the collection of data.
day=`date | cut -d ' ' -f1-4`
time=`date | cut -d ' ' -f4`
folder="/home/`whoami`/TrueLayer"
runningfolder=`pwd`

#We create the directory of the user that executes the script if it does not exist
if [ ! -d "$folder" ]
then
        echo "Hello!"
        mkdir -p "$folder"
fi

#This step is not necessary because it is created automatically when you output the information to a file, but I add it as a point in the exercise. (Create file)
touch $folder/TLTest.txt

echo "------------------------ START EXECUTION $day ------------------------" >> $folder/TLTest.txt
echo "Time when the script has been run: $time" >> $folder/TLTest.txt
echo "Name of the script: " $BASH_SOURCE >> $folder/TLTest.txt
echo "Full list files and folders: " `$runningfolder | ls *` >> $folder/TLTest.txt







echo "--------------------------------------- END -----------------------------------------" >> $folder/TLTest.txt
echo "" >> $folder/TLTest.txt