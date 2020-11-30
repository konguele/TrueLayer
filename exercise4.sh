#!/bin/bash
# script_exercise4.sh
# created by Juanjo Garcia

SCRIPT=/tmp/script_exercise4.sh         # Name of the file to generate.

#We start the cat EOF so that it creates the shell script
(
cat << 'EOF'
#!/bin/bash
#Script created by Juanjo Garcia

echo "This is a generated shell script by exercise4.sh"

FOLDER=/tmp/TrueLayer              # We create the variable of the directory on which we are going to work
NEW_LOCATION=/tmp/backup

#I have created a small form to be able to choose different ways to do it. Giving a path or using the demo

echo "Would you like to try exercise 4 with your own path or use the demo?"
echo ""
echo "1) Your own path"
echo "2) Demo"
echo "3) Exit"

read option

case $option in
        1)
         echo "Tell me your folder (Please specify complete path):"
         read FOLDER
         ;;
        2)
         #We check if it exists, if it does not exist it will create it
         if [ ! -d "$FOLDER" ]
         then
                mkdir -p "$FOLDER"
                touch $FOLDER/file1.txt
                echo -n $'\x01' > $FOLDER/binary.dat
                mkdir -p $FOLDER/TrueLayer2
                touch $FOLDER/TrueLayer2/file200.txt
                echo -n $'\x01' > $FOLDER/TrueLayer2/binary_10.dat
         fi
         ;;
        3)
         echo "OK, see you!"
         exit 0
         ;;
        *)
         echo "That is not a valid choice"
         exit 0
         ;;
esac

#After doing the first part, we put the files from the chosen path in a form. We do the same with the folder hierarchy

find $FOLDER -type f > /tmp/form.txt
ls -R $FOLDER | grep ":" | awk -F $FOLDER '{print $2}' | cut -d":" -f1 | grep -v ^$ > /tmp/folderhierarchy.txt

echo "The form with the data has been generated"

#We create the new location, in this case called backup inside / tmp

if [ ! -d "$NEW_LOCATION" ]
then
        mkdir -p "$NEW_LOCATION"
        mkdir -p "$NEW_LOCATION$FOLDER"
        LOCATION="$NEW_LOCATION$FOLDER"
else
        mkdir -p "$NEW_LOCATION$FOLDER"
        LOCATION="$NEW_LOCATION$FOLDER"
fi

#The two while loops are used to recreate the hierarchy and copy the files to the correct place

while read line
do
        mkdir -p $LOCATION/$line

done < /tmp/folderhierarchy.txt

while read line
do
        cp -r -a $line $NEW_LOCATION$line

done < /tmp/form.txt

exit 0
EOF
) > $SCRIPT

#Once the EOF is finished, we check that the generated script has the correct permissions and we execute it

if [ -f "$SCRIPT" ]
then
  chmod 755 $SCRIPT
  # Make the generated file executable.
else
  echo "Problem in creating file:" $SCRIPT
fi

sh $SCRIPT
