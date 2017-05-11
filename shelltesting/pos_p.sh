#!/bin/bash
VAR_1=$1
VAR_2=$2
VAR_3=$3
VAR_4=$4

echo $VAR_1
echo $VAR_2
echo $VAR_3
echo $VAR_4

#running ./pos_p.sh one two three four will result with
#one
#two
#three
#four
#printed to the terminal

if [ "$VAR_1" = "hello" ]
then
    echo "Hello World"
fi
