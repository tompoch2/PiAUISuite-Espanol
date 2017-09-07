# PiAUSuite-Espa-ol-
PiAUSuite (Español)

# Interfaz de usuario alternativa

Incluye voicecommand, download, playvideo, and textcommand scripts

Esto requiere:

* boost
* curl
* xterm
* espeak
* algunas otras cosas

Para instalar las dependencias, ejecute:
```bash
sudo apt-get install -y libboost-dev libboost-regex-dev youtube-dl axel curl xterm libcurl4-gnutls-dev mpg123 flac sox
```

Para instalar PiAUISuite:
```bash
git clone https://github.com/StevenHickson/PiAUISuite.git
cd PiAUISuite/Install
./InstallAUISuite.sh
```

Va a:
* preguntar si desea instalar las dependencias
* para instalar cada secuencia de comandos

## Diferentes Partes

Nombre | Proposito | Blogpost
-----|---------|---------
playvideo | encuentra y reproduce videos | [Here](http://stevenhickson.blogspot.com/2013/03/playing-videos-intelligently-with.html)
downloader | encontrar y descargar el mejor torrent | [Here](http://stevenhickson.blogspot.com/2013/03/automatically-downloading-torrents-with.html)
gvapi | comprueba, envía y elimina mensajes SMS | [Here](http://stevenhickson.blogspot.com/2013/05/using-google-voice-c-api.html)
gtextcommand | comprueba mensajes sms cada minuto y ejecuta comandos desde ellos | [Here](http://stevenhickson.blogspot.com/2013/03/controlling-raspberry-pi-via-text.html)
youtube | streams de youtube | [In browser](http://stevenhickson.blogspot.com/2013/06/playing-youtube-videos-in-browser-on.html) and [on Pi](http://stevenhickson.blogspot.com/2013/04/using-youtube-on-raspberry-pi-without.html)
youtube-safe | transmite otros archivos de video | [Hulu and Vimeo](http://stevenhickson.blogspot.com/2013/06/getting-huluvimeo-to-work-on-raspberry.html) and [others](http://stevenhickson.blogspot.com/2013/06/streaming-other-hd-video-sites-on.html)
voicecommand | ejecuta comandos de voz | [Here](http://stevenhickson.blogspot.com/2013/05/voice-command-v20-for-raspberry-pi.html) and [here](http://stevenhickson.blogspot.com/2013/04/voice-control-on-raspberry-pi.html)

Copyright

[GPLv3](https://tldrlegal.com/license/gnu-general-public-license-v3-(gpl-3))

Steven Hickson

