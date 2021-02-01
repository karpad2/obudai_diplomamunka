//
// Created by karpad2 on 1/9/2021.
//


#ifndef ESP32_CONFIG_H
#define ESP32_CONFIG_H
#define PORT 9000
#define USBPORT 9600
#include <SPI.h>
#include "SPIFFS.h"
#include <ArduinoJson.h>

struct Config {
  char hostname[64];
  int port;
};

Config config;
const char *filename = "/config.json";
const char *web_server="http://46-40-46-94.sslip.io/escape_room/index.php"; //host webaddress
StaticJsonDocument<512> doc;
const char* ssid=  "TP-Link";
const char*  password=  "asdfghjkl123#";
unsigned long previousMillis = 0;
unsigned long currentMillis = 0;
int relaystate=0;
const char* ok ="[OK!]";
const char* dots ="...";
enum relaymode{on,off};


#define rfid_pins 14
#define SS_PIN    21
#define RST_PIN   22
#define SIZE_BUFFER     18
#define MAX_SIZE_BLOCK  16
#define led  2
#define relaypin 5

void pinouts()
{
    SPI.begin();
    pinMode(led, OUTPUT);
    pinMode(relaypin, OUTPUT);
    digitalWrite(led, 0);
    digitalWrite(relaypin, 0);
}

void blinking(int _i)
{
    currentMillis=millis();
    for (int i=0;i<_i;i++)
    {
      digitalWrite(led, 1);
      delay(200);
      digitalWrite(led, 0);
      delay(200);
    }
}

void relay(int _a)
{
  
  if(_a==1)  
  {digitalWrite(relaypin, 1);
  blinking(1);}
  else if(_a==0)  {digitalWrite(relaypin, 0);
  blinking(1);}
  else {}
}

void fs_setup()
{
  blinking(2);
  Serial.print("Mounting FS");
    if(!SPIFFS.begin(true)){
        Serial.println("An Error has occurred while mounting SPIFFS");
        return;
    }
     File credFile = SPIFFS.open("/config.json", "r");
     if (!credFile)
    {
        Serial.println("Failed to open config file");
        return;
    }
    Serial.println(ok);
 }

 void read_config()
 {
  File configfile = SPIFFS.open("/config.json", "r");
  configfile.close();
 }
 void save_config()
 {
  File configfile = SPIFFS.open("/config.json", "r");
  configfile.close();
 }

 void httpmod()
 {
  HTTPClient http;
        USE_SERIAL.print("[HTTP] begin...\n");
        // configure traged server and url
        //http.begin("https://www.howsmyssl.com/a/check", ca); //HTTPS
        http.begin(web_server+"?ajax&esp_status="+s_rfid); //HTTP

        USE_SERIAL.print("[HTTP] GET...\n");
        // start connection and send HTTP header
        int httpCode = http.GET();

        // httpCode will be negative on error
        if(httpCode > 0) {
            // HTTP header has been send and Server response header has been handled
            USE_SERIAL.printf("[HTTP] GET... code: %d\n", httpCode);

            // file found at server
            if(httpCode == HTTP_CODE_OK) {
                String payload = http.getString();
                USE_SERIAL.println(payload);
            }
        } else {
            USE_SERIAL.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
        }

        http.end();
 }





#endif //ESP32_CONFIG_H
