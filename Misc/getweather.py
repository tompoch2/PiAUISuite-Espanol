import pywapi
import string
import sys

#this requires pywapi which can be installed from https://code.google.com/p/python-weather-api/
#If in the US 00000 should be your area code
#If in Britain, try using the BBC weather scripts found here: https://github.com/duncanj/voice_scripts

# pass a second parameter, 'imperial' if you are feeling like ferinheight instead of celsius
result = pywapi.get_weather_from_weather_com(str(sys.argv[1]))

print "Es " + string.lower(result['current_conditions']['text']) + " y " + result['current_conditions']['temperature'] + " grados."
print "Humedad " + result['current_conditions']['humidity'] + " por ciento."

today = result['forecasts'][0]
highToday = today['high']
if highToday > result['current_conditions']['temperature']:
    print "El máximo esperado es " + highToday + "."

print "Durante la noche, " + today['night']['text'] + " con una minima de " + today['low'] + " "
if today['night']['chance_precip'] != "0":
    print " y un " + today['night']['chance_precip'] + " de Probabilidad de lluvia."

tomorrow = result['forecasts'][1]
print "Mañana, "+ tomorrow['day']['text'] + " con una maxima de " + tomorrow['high'] + " "

if tomorrow['day']['chance_precip'] != "0":
    print " y un " + tomorrow['day']['chance_precip'] + " de Probabilidad de lluvia."
