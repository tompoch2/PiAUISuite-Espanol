#!/bin/bash

#we need a contacts folder, this will be obtained and updated using gvapi -i and will be in ~/.contacts

function sendtext() {
    local filler="FILLER FILL"
    local arrs=`echo "$1" | tr "==" "\n"`
    local count=1
    local okay=0
    while read -r x
    do
        if [ "$count" == 1 ] ; then
            tts "$filler ¿Qué le gustaría pasar a texto a $x"
        elif [ "$count" == 3 ] ; then
            while [ $okay == 0 ]
            do
                local message=`speech-recog.sh -d 10 | tr -d '"'`
                tts "$filler tengo un $message. es correcto?"
                yes=`speech-recog.sh`
                if [[ "$yes" == *"yes"* ]] ; then
                    gvapi -n "$x" -m "$message"
                    okay=1
                    exit
                fi
            done
        fi
        count=`echo "$count + 1" | bc`        
    done <<< "$arrs"
}

if [ $# -gt 0 ] ; then
    if [ $1 == "-u" ] ; then
        echo "Actualizando contactos"
        gvapi -i > ~/.contacts
        exit
    fi

    results=`cat ~/.contacts | grep -i "$@"`
    num=`echo "$results" | wc -l`
    if [ $num -gt 1 ] ; then
        echo "no esta listo todavía"
    elif [ $num == 1 ] ; then
        #I need to split the string
        sendtext "$results"
    fi
else
    echo "No se encontró var."
fi
