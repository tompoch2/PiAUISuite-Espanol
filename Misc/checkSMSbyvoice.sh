#!/bin/bash

filler="FILLER FILL"
texts=`gvapi -c`
if [ "$texts" != "" ] ; then
    echo "Mensaje encontrado"
    name=`echo $texts | awk -F':' '{print $1}'`
    message=`echo $texts | awk -F':' '{print $2}'`
    tts "$filler mensaje de $name"
    sleep 0.5
    tts "$filler $message"
else
    echo "No hay mensajes"
    tts "$filler no hay mensajes"
fi
