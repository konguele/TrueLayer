#!/bin/bash
# script_exercise4.sh
# created by Juanjo Garcia

SCRIPT=script_exercise4.sh         # Name of the file to generate.
FOLDER=/tmp/TrueLayer              # We create the variable of the directory on which we are going to work

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

cat << CONVERT

`find $FOLDER -type f > /tmp/form.txt`

The form with the data has been generated

CONVERT

(
cat << 'EOF'
#!/bin/bash
#Script created by Juanjo Garcia

NEW_LOCATION=/tmp/backup/

echo "This is a generated shell script by exercise4.sh"

echo "I start to run the script: $SCRIPT"

if [ ! -d "$NEW_LOCATION" ]
then
        mkdir -p "$NEW_LOCATION"
fi

while read line; do
cp -r -a $line $NEW_LOCATION
echo "Funciona"
done < /tmp/form.txt

exit 0
EOF
) > $SCRIPT

if [ -f "$SCRIPT" ]
then
  chmod 755 $SCRIPT
  # Make the generated file executable.
else
  echo "Problem in creating file:" $SCRIPT
fi

sh $SCRIPT