#!/bin/bash
#script_exercise4.sh
#created by Juanjo Garcia

SCRIPT=script_exercise4.sh         #Name of the file to generate.
FOLDER=/tmp/TrueLayer              #We create the variable of the directory on which we are going to work

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

#We convert the folder hierarchy into a form using cat EOF
cat << converttoform
`ls -R $FOLDER > /tmp/form.txt`
converttoform

#Seguramente tenga que usar un bucle (While read) y el comando find. Así me busca dónde está y lo coloca dentro de la nueva ubicación, las carpetas puede crearlas de nuevo
#We create the script that will process the information and will generate the folder hierarchy in a new path
(
cat << EOF
#!/bin/bash

echo "This is a generated shell script."
#  Note that since we are inside a subshell,
#+ we can't access variables in the "outside" script.

echo "Generated file will be named: $OUTFILE"
#  Above line will not work as normally expected
#+ because parameter expansion has been disabled.
#  Instead, the result is literal output.

a=7
b=3

let "c = $a * $b"
echo "c = $c"

exit 0
EOF
) > $OUTFILE
# -----------------------------------------------------------

#  Quoting the 'limit string' prevents variable expansion
#+ within the body of the above 'here document.'
#  This permits outputting literal strings in the output file.

if [ -f "$OUTFILE" ]
then
  chmod 755 $OUTFILE
  # Make the generated file executable.
else
  echo "Problem in creating file: \"$OUTFILE\""
fi

#  This method also works for generating
#+ C programs, Perl programs, Python programs, Makefiles,
#+ and the like.

exit 0