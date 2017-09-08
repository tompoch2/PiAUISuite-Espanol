# PiAUSuite (Español)

# No probado al 100%

Traducción al Español de PiAUSuite Original de Steven Hickson

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
git clone https://github.com/tompoch2/PiAUISuite-Espanol.git
cd PiAUISuite-Espanol/Install
./InstallAUISuite.sh
```

Va a:
* preguntar si desea instalar las dependencias
* para instalar cada secuencia de comandos

## Componentes

Nombre | Proposito | Blogpost
-----|---------|---------
playvideo | encuentra y reproduce videos | [Aquí](http://stevenhickson.blogspot.com/2013/03/playing-videos-intelligently-with.html)
downloader | encontrar y descargar el mejor torrent | [Aquí](http://stevenhickson.blogspot.com/2013/03/automatically-downloading-torrents-with.html)
gvapi | comprueba, envía y elimina mensajes SMS | [Aquí](http://stevenhickson.blogspot.com/2013/05/using-google-voice-c-api.html)
gtextcommand | comprueba mensajes sms cada minuto y ejecuta comandos desde ellos | [Aquí](http://stevenhickson.blogspot.com/2013/03/controlling-raspberry-pi-via-text.html)
youtube | streams de youtube | [En Navegador](http://stevenhickson.blogspot.com/2013/06/playing-youtube-videos-in-browser-on.html) y [en Pi](http://stevenhickson.blogspot.com/2013/04/using-youtube-on-raspberry-pi-without.html)
youtube-safe | transmite otros archivos de video | [Hulu y Vimeo](http://stevenhickson.blogspot.com/2013/06/getting-huluvimeo-to-work-on-raspberry.html) y [otros](http://stevenhickson.blogspot.com/2013/06/streaming-other-hd-video-sites-on.html)
voicecommand | ejecuta comandos de voz | [Aquí](http://stevenhickson.blogspot.com/2013/05/voice-command-v20-for-raspberry-pi.html) y [Aquí](http://stevenhickson.blogspot.com/2013/04/voice-control-on-raspberry-pi.html)

Copyright

[GPLv3](https://tldrlegal.com/license/gnu-general-public-license-v3-(gpl-3))

Steven Hickson

