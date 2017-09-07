#!/bin/bash

#Script to make install of AUI Suite very easy
function dependencies() {
    ARCH=$1
    #Ask to install dependencies
    install_method=`pgrep apt-get`
    if [ -z $install_method ] ; then
    echo "Instalar dependencias? s/n"
    echo "Estas son necesarias para cualquiera de las opciones, por lo que probablemente debería instalarlas a menos que usted sabe que las tiene instaladas."
    read option
    if [ $option == "s" ] || [ $option == "S" ] ; then
        if [ "$ARCH" == "armv6l" ] ; then
            sudo apt-get install locate curl libboost-dev libboost-regex-dev xterm xfonts-base xfonts-utils youtube-dl axel mpg123 libcurl4-openssl-dev flac sox
        else
            sudo apt-get install locate curl libboost-dev libboost-regex-dev xterm xfonts-base xfonts-utils youtube-dl axel mpg123 libcurl4-openssl-dev flac sox
        fi
    fi
    fi
}

function playvideo_install() {
    #Install playvideo script
    echo "Instalar playvideo? s/n"
    echo "Este script indexa sus películas y programas de televisión con el fin de encontrarlos rápidamente, al azar o reproducirlos."
    read option
    if [ $option == "s" ] || [ $option == "S" ] ; then
    echo "Instalando playvideo"
    echo "Introduzca la ubicación de la carpeta raíz de movie/video, ejemplo: /media/External/movies"
    read media_path
    `../PlayVideoScripts/playvideo -set "$media_path"`
    sudo cp ../PlayVideoScripts/playvideo /usr/bin/playvideo
    sudo cp ../PlayVideoScripts/playvideo.8.gz /usr/share/man/man8/
    echo "Listo playvideo instalado!"
    else
        echo "Saltando instalación de playvideo"
    fi
}

function download() {
    DIR=$1
    USER_HOME="$2"
    #Install downloader script
    echo "Instalar downloader? s/n"
    echo "Este script automatiza la descarga de torrents. Ej. 'download wheezy' encuentra y descarga la más nueva imagen debian wheezy"
    read option
    if [ $option == "s" ] || [ $option == "S" ] ; then
    echo "Instalando downloader"
    echo "Ingrese Host: ej, localhost (probablemente sea este)"
    read host
    echo "Ingrese el  Puerto: por defecto es 9091"
    read port
    echo "Ingrese el nombre de usuario, pulse Intro si no hay."
    read user
    echo "Ingrese contraseña, pulse Intro si no hay"
    read passwd
    #print commands to $USER_HOME/.down.info
    if [ -e "$USER_HOME/.down.info" ] ; then
        sudo rm -f "$USER_HOME/.down.info"
    fi
    echo "$host"   | sudo tee -a "$USER_HOME/.down.info" >/dev/null
    echo "$port"   | sudo tee -a "$USER_HOME/.down.info" >/dev/null
    echo "$user"   | sudo tee -a "$USER_HOME/.down.info" >/dev/null
    echo "$passwd" | sudo tee -a "$USER_HOME/.down.info" >/dev/null
    tmp="../DownloadController/"
    tmp+="$DIR"
    tmp+="download"
    sudo cp "$tmp" /usr/bin/download
    echo "Listo download instalado!"
    else
        echo "Saltando instalacion de downloader"
    fi
}

function gvapi() {
    DIR=$1
    USER_HOME="$2"
    #Install gvapi
    echo "Instalar gvapi (googlevoice API)? s/n"
    echo "Este script instala la api de voz de google. Es muy útil para los domóticos y los aficionados a la robótica."
    read option
    if [ $option == "s" ] || [ $option == "S" ] ; then
        echo "Instalando Text Command Script"
        echo "Ingrese usuario de google voice: "
        read user
        echo "Ingrese contraseña de google voice: "
        read passwd
        #print commands to $USER_HOME/.gtext
        if [ -e "$USER_HOME/.gv" ] ; then
            sudo rm -f "$USER_HOME/.gv"
        fi
        echo "$user"   | sudo tee -a "$USER_HOME/.gv" >/dev/null
        echo "$passwd"   | sudo tee -a "$USER_HOME/.gv" >/dev/null
        tmp="../TextCommand/"
        tmp+="$DIR"
        tmp+="gvapi"
        sudo cp "$tmp" /usr/bin/gvapi
        sudo cp ../TextCommand/gvapi.8.gz /usr/share/man/man8/
        echo "Listo gvapi instalado!"
    else
        echo "Saltando instalacion de gvapi"
    fi
}

function gtextcommand {
    DIR=$1
    USER_HOME="$2"
    #Install gtextcommand script
    echo "Instalar gtextcommand (sistema de comandos de texto a voz de google)? s/n"
    echo "Esto instala gtextcommand. Esto utiliza la google voice para comprobar los comandos del sistema con tu número y un código de acceso."
    read option
    if [ $option == "s" ] || [ $option == "S" ] ; then
    echo "Instalando Script de Text Command"
    echo "Ingresa usuario de google voice: "
    read user
    echo "Ingresa la contraseña de google voice: "
    read passwd
    echo "Escriba la palabra comando clave, ej: Cmd (esto procederá con cada comando valido)"
    read key
    echo "Ingrese un número válido para aceptar comandos de (asegúrese de poner el código del país pero no el +) ej: 15553334444"
    read number
    #print commands to $USER_HOME/.gtext
    if [ -e "$USER_HOME/.gtext" ] ; then
        sudo rm -f "$USER_HOME/.gtext"
    fi
    echo "$user"   | sudo tee -a "$USER_HOME/.gtext" >/dev/null
    echo "$passwd"   | sudo tee -a "$USER_HOME/.gtext" >/dev/null
    echo "$key"   | sudo tee -a "$USER_HOME/.gtext" >/dev/null
    echo "$number" | sudo tee -a "$USER_HOME/.gtext" >/dev/null
    tmp="../TextCommand/"
    tmp+="$DIR"
    tmp+="gtextcommand"
    sudo cp "$tmp" /usr/bin/gtextcommand
    #Add to cron.d
    echo "Instalación lista, configuración de script cron ..."
    if [ -e "/etc/cron.d/gtextcommand" ] ; then
        sudo rm -f "/etc/cron.d/gtextcommand"
    fi
    cronjob="#!/bin/sh
    #
    # cron script to check google voice.
    #
    # Written by Steven Hickson <help@stevenhickson.com> for the gtextcommand script.
    #
    DISPLAY=:0

    * * * * * $USER gtextcommand

    "
    echo "$cronjob" | sudo tee -a /etc/cron.d/gtextcommand >/dev/null
    sudo sh -c 'chmod +x /etc/cron.d/gtextcommand'
    echo "Listo gtextcommand instalado!"
    else
        echo "Saltando instalacion de gtextcommand"
    fi
}

function youtube() {
    DIR=$1
    USER_HOME="$2"
    echo "Instalar scripts de youtube? s/n"
    echo "Esto instala youtube, youtube-safe, youtube-dl y otras secuencias de comandos que le permiten descargar, transmitir y explorar videos desde muchos sitios"
    read option
    if [ $option == "s" ] || [ $option == "S" ] ; then
        tmp="../Youtube/"
        tmp+="$DIR"
        tmp+="youtube-search"
        sudo cp ../Youtube/youtube /usr/bin/
        sudo cp ../Youtube/youtube-safe /usr/bin/
        sudo cp ../Youtube/youtube-dlfast /usr/bin/
        sudo cp "$tmp" /usr/bin/
        sudo cp ../Youtube/update-youtubedl /etc/cron.daily/
        sudo cp ../Youtube/yt.desktop /usr/share/applications/
        sudo cp ../Youtube/ytb.desktop /usr/share/applications/
        mkdir -p "$USER_HOME/.local/share/midori/scripts"
        cp ../Youtube/yt.js "$USER_HOME/.local/share/midori/scripts/" 
        cp ../Youtube/ytb.js "$USER_HOME/.local/share/midori/scripts/" 
        #This however, I'm fairly certain I need
        sudo update-desktop-database
        sudo youtube-dl -U
    else
        echo "Saltando instalacion de youtube"
    fi
}

function voicecommand_install() {
    DIR=$1
    USER_HOME="$2"
    echo "Instalar voicecommand? s/n"
    echo "Éste es probablemente el Script más cool aquí y que además une a los otros Script. Es un sistema de control de voz fácilmente personalizable que utiliza el reconocimiento de voz y el texto a voz para escucharte, responderte y ejecutar comandos basados en lo que dices."
    read option
    if [ $option == "s" ] || [ $option == "S" ] ; then
        tmp="../VoiceCommand/"
        tmp+="$DIR"
        tmp+="voicecommand"
        sudo cp "$tmp" /usr/bin/
        sudo cp ../VoiceCommand/google /usr/bin/
        sudo cp ../VoiceCommand/tts /usr/bin/
        sudo cp ../VoiceCommand/speech-recog.sh /usr/bin/
        sudo cp ../VoiceCommand/voicecommand.8.gz /usr/share/man/man8/
        if [[ ! -f "$USER_HOME/.commands.conf" ]] ; then
	    echo "No se ha encontrado commands.conf, se usaran los datos por defecto"
            cp ../VoiceCommand/commands.conf "$USER_HOME/.commands.conf"
	else
	    echo "Encontré un archivo commands.conf"
        fi
        echo "¿Te gustaría que voicecommand intentara configurarse? s/n"
        read option
        if [ $option == "s" ] || [ $option == "S" ] ; then
            voicecommand -s
        else
            echo "Puedes hacerlo manualmente en cualquier momento ejecutando voicecommand -s"
        fi
    else
        echo "Saltando instalación de voicecommand"
    fi
}

echo "Instalación de AUI Suite (ESPAÑOL) por Steven Hickson/Tompoch2"
echo "Si tiene problemas, visite stevenhickson.blogspot.com o envíe un correo electrónico a help@stevenhickson.com"

#Get architecture
ARCH=`uname -m`
if [ "$ARCH" == "armv6l" ] ; then
    DIR=""
elif [ "$ARCH" == "x86" ] ; then
    DIR="x86/"
elif [ "$ARCH" == "x86_64" ] ; then
    DIR="x64/"
fi

if [ "$(id -u)" != "0" ]; then
    USER_HOME="$HOME"
else
    USER_HOME="/home/${SUDO_USER}"
fi

ARG="$1"
if [ "$ARG" == "dependencies" ] ; then 
    dependencies "$ARCH"
elif [ "$ARG" == "playvideo" ] ; then 
    playvideo_install
elif [ "$ARG" == "download" ] ; then 
    download "$DIR" "$USER_HOME"
elif [ "$ARG" == "gtextcommand" ] ; then
    gtextcommand "$DIR" "$USER_HOME"
elif [ "$ARG" == "gvapi" ] ; then
    gvapi "$DIR" "$USER_HOME"
elif [ "$ARG" == "youtube" ] ; then
    youtube "$DIR" "$USER_HOME"
elif [ "$ARG" == "voicecommand" ] ; then
    voicecommand_install "$DIR" "$USER_HOME"
else
    dependencies "$ARCH"
    playvideo_install
    download "$DIR" "$USER_HOME"
    gtextcommand "$DIR" "$USER_HOME"
    gvapi "$DIR" "$USER_HOME"
    youtube "$DIR" "$USER_HOME"
    voicecommand_install "$DIR" "$USER_HOME"
fi
