// GoogleVoice API. v2.0.1 Steven Hickson
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <termios.h>
#include <unistd.h>
//#include <boost/regex.hpp>
#include "gvoice.h"

using namespace std;
//using namespace boost;

void PrintUsage(int verbose=0);

int main(int argc, char *argv[])
{
	GoogleVoice gv;
	int a,d,r;
    bool check_sms = false, send_sms = false, delete_sms = false, contact_info = false;
    string keyword="";
	string an,am;
	string au,ap;

    bool config = true;

	while((a=getopt(argc,argv, "d::h?vu:p:irck:n:m:")) != -1)
	{
		switch(a)
		{
            case 'i':
                contact_info = true;
                break;
			case 'd':	// debug mode.
				if(optarg) d=atoi(optarg); else d=1;
                printf("Nivel de depuración %d habilitado\n",d);
				gv.debug=d;
				break;
			case 'u':	// username
                config=false;
				au=optarg;
				break;
			case 'p':	// password
				ap=optarg;
				break;
			case 'n':	// number
				an=optarg;
				break;
			case 'm':	// message
				am=optarg;
                send_sms = true;
				break;
            case 'r':   // receive messages (delete)
                check_sms = true;
                delete_sms = true;
                break;
            case 'c':   // check messages (mark as read)
                check_sms = true;
                break;
            case 'k':   // keyword for checking messages
                keyword = optarg;
                break;
			case '?':
			case 'h':	// help
				PrintUsage(1); return 0;
			case 'v':	// version.
				printf("GoogleVoice API por Steven Hickson.  %s.  https://github.com/StevenHickson/PiAUISuite\n\n", "2.0");
				return 0;
		}
	}
    if((send_sms && an.empty()) || (!keyword.empty() && !check_sms) || (delete_sms && !check_sms) || (ap.empty() ^ au.empty())) {
        printf("Error, combinación de indicador incorrecta\n");
        PrintUsage(1);
    }

	if(gv.Init()) {cout << "GoogleVoice () no se pudo inicializar. Culpar curl. Dying.\n"; return -1;}
    
    //Let's fill in the config options if they weren't specified
    if(config) {
        FILE *fp;
        char *passPath;
        passPath = getenv("HOME");
        if(passPath == NULL) {
            printf("No pude encontrar $HOME\n");
            return -1;
        }
        string path = string(passPath);
        path += "/.gv";
        fp = fopen(path.c_str(),"r");
        if(!fp) {cout << "No se pudo abrir el archivo de contraseñas. Dying\n"; return -1;}
        char buf1[100];
        char buf2[100];
        fscanf(fp,"%s\n%s\n",buf1,buf2);
        fclose(fp);
        au = string(buf1);
        ap = string(buf2);
    }

	r = gv.Login(au,ap);
	if((gv.debug&1) || r) printf("gv.Login() retorno %d.\n\n", r);
    
    if(contact_info) {
        gv.GetContactInfo();  
    } else if(check_sms) {
        string results;
        string number = "";
        if(!an.empty())
            number += an;
        r = gv.CheckSMS(results,number,keyword,delete_sms);
        printf("%s\n",results.c_str());
        if(!r && gv.debug) printf("SMS comprobado con éxito.\n");
    } else {
	    r = gv.SendSMS(an,am);
	    if((gv.debug&2) || r) printf("gv.SendSMS() retorno %d.\n\n", r);
	    if(!r) printf("SMS enviado satisfactoriamente.\n");
    }
    
	return r;
}

void PrintUsage(int verbose)
{
	printf("Uso: %s -hdicr -u [username] -p [password] -k [keyword] -n [number] -m [textmsg]\n", "gvapi");	//argv[0]);
	if(!verbose) return;
	printf("\t-d{n}:\t\tEstablecer depuración (verbosidad).  Si el valor de depuración {n} no se especifica, el valor predeterminado es 1.\n\t\t\tbits de depuración: 1 = salida GV llamadas. 2 = descargar resultados de llamada GV.\n");
    printf("Para obtener más ayuda, escriba man gvapi en su shell\n");
}

