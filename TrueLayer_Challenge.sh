#!/bin/bash
#Script created by Juanjo for the TrueLayer challenge.

#We declare the variables necessary for the correct execution of the script and the collection of data.
day=`date +"%A %d %B"`
time=`date +%T`
folder="/home/`whoami`/TrueLayer"
runningfolder=`pwd`
public_IP=`wget -qO- ifconfig.co/ip`
total_mem=`free -m | grep Mem | sed 's/\s\+/,/g' | cut -d , -f2`
mem_avail=`free -m | grep Mem | sed 's/\s\+/,/g' | cut -d , -f4`
user=`ps -ef | grep -i $BASHPID | sed 's/\s\+/,/g' | cut -d , -f1`

#We create the directory of the user that executes the script if it does not exist
if [ ! -d "$folder" ]
then
        mkdir -p "$folder"
fi

#This step is not necessary because it is created automatically when you output the information to a file, but I add it as a point in the exercise. (Create file)
touch $folder/TLTest.txt

#We mark the start of the execution
echo "------------------------ START EXECUTION $day ------------------------" >> $folder/TLTest.txt

#It only shows us the time
echo "Time when the script has been run: $time" >> $folder/TLTest.txt

#It shows us the name of the script
echo "Name of the script: " $BASH_SOURCE >> $folder/TLTest.txt

#It shows us the files and directories of the running directory, if we want to see everything that is inside the subdirectories we would use ls *
echo "Full list files and folders: " `ls -a $runningfolder` >> $folder/TLTest.txt

#When declaring the variable we execute the command that shows the public IP, we could also see it with a curl command
echo "Public IP: $public_IP" >> $folder/TLTest.txt

#In the variable we have used the free -m to obtain the memory in Mb.
echo "Available memory is: $mem_avail MB (totally amount memory is: $total_mem MB)" >> $folder/TLTest.txt

#We use the variable $BASHPID to show us the PID of the process
echo "PID: " $BASHPID >> $folder/TLTest.txt

#In the variable we use the ps -ef command to list the processes, find the one that interests us and show the user who executes it
echo "Run by user: " $user >> $folder/TLTest.txt

#We end with a comment and a blank line so that it is better to see where the next one begins
echo "--------------------------------------- END -----------------------------------------" >> $folder/TLTest.txt
echo "" >> $folder/TLTest.txt

#Shows on screen where the created file and the folder are
echo "You can find the exercise in: $folder"
