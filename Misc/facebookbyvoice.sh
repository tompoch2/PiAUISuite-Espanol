#!/bin/bash 
user=`cat $HOME/.misc | awk -F'username==' '{print $2}' | tr -d '\n'`
pass=`cat $HOME/.misc | awk -F'password==' '{print $2}' | tr -d '\n'`

okay=0
filler="FILLER FILL"
tts "$filler Que te gustaría publicar"
while [ $okay == 0 ]
do
    message=`speech-recog.sh -d 10 | tr -d '"'`
    tts "$filler tengo un $message. ¿Es esto correcto?"
    yes=`speech-recog.sh`
    if [[ "$yes" == *"yes"* ]] ; then
        python /home/pi/AUI/Misc/post_facebook.py "$user" "$pass" "$message"
        okay=1
        exit
    else
        tts "$filler Ok, inténtalo de nuevo"
    fi
done
