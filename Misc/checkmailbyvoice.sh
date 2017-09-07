#!/bin/bash

filler="FILLER FILL"
#Message from: name says: message
user=`cat $HOME/.misc | awk -F'username==' '{print $2}' | tr -d '\n'`
pass=`cat $HOME/.misc | awk -F'password==' '{print $2}' | tr -d '\n'`

texts=`python /home/pi/AUI/Misc/check_gmail.py "$user" "$pass"`
if [ "$texts" != "" ] ; then
    echo "Mensaje encontrado"
    printf "%s\n" "$texts" | 
    while IFS= read -r line
    do
        name=${line#*from:}
        name=${name%says:*}
        message=${line#*says:}
        echo "mensaje de $name"
        tts "$filler mensaje de $name"
        sleep 0.5
        echo "    $message"
        tts "$filler $message"
    done 
else
    echo "No hay mensajes"
    tts "$filler no hay mensajes"
fi
