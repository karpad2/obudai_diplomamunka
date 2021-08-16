//
// Created by karpad2 on 1/9/2021.
//
#ifndef ESP32_CONFIG_H
#define ESP32_CONFIG_H
#define PORT 9000
#define USBPORT 9600
#define rfid_pins 14
#define SS_PIN    21
#define RST_PIN   22
#define SIZE_BUFFER     18
#define MAX_SIZE_BLOCK  16
#define led  2
#define relaypin 23
#define interruptpin 25

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels



#include <SPI.h>
#include "SPIFFS.h"
#include <Arduino_JSON.h>
#include <MFRC522.h>
#include <HTTPClient.h>
#include <Wire.h>

#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>


Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);


struct Config {
  char hostname[64];
  int port;
};

void IRAM_ATTR isr();
String http_sys(String address);
Config config;
JSONVar tmp1;
char char_array[512];
String configtext="";
String filename = "/config.json";
String web_server="http://192.168.0.101/api/";
String ssid =  "Escape Room";
String pass =  "escape_room";
String esp32_pass="";
String espstatus="";
unsigned long previousMillis = 0;
unsigned long currentMillis = 0;
JSONVar configobj;
int relaystate=0;
String ok ="[OK!]";
String dots ="...";
enum relaymode{on,off};
String tmpaddress="";
String s_rfid="";

MFRC522 rfid(SS_PIN, RST_PIN);
MFRC522::MIFARE_Key key;
byte nuidPICC[4];
 
void pinouts()
{
    SPI.begin();
    pinMode(led, OUTPUT);
    pinMode(relaypin, OUTPUT);
    pinMode(interruptpin, INPUT_PULLUP);
    digitalWrite(led, 0);
    digitalWrite(relaypin, 0);
    if(espstatus=="rfid")
    { 
    rfid.PCD_Init(); // Init MFRC522
    
    for (byte i = 0; i < 6; i++) {
        key.keyByte[i] = 0xFF;
    }
      
    }else if(espstatus=="input")
    {
      attachInterrupt(interruptpin, isr, FALLING); 
    }
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
  else { }
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
    else 
    {
      String tmp1="";
      Serial.println("Config File read");
      configtext=credFile.readString();
       configobj=JSON.parse(configtext);
       ssid=(const char*)configobj["Wifi-name"];
       pass=(const char*)configobj["Wifi-pass"];
       esp32_pass=configobj["esp32pass"];
       web_server=(const char*)configobj["webserveraddress"];
       espstatus=(const char*)configobj["device_mode"];
       tmp1=JSON.stringify(configobj);
       Serial.println(tmp1);
    }
    Serial.println(ok);
 }

 void save_config()
 {
  String config_string="";
  //configobj.
  File configfile = SPIFFS.open("/config.json", FILE_WRITE);
  if(!configfile){
    Serial.println("There was an error opening the file for writing");
    return;
  }
  else
  {
    configfile.print(JSON.stringify(configobj));
  }
    delay(100);
    configfile.close();
 }
  String http_sys(String address)
 {
  HTTPClient http;
  String payload="";
  http.begin(address); //HTTP
        Serial.print("[HTTP] GET...\n");
       
        int httpCode = http.GET();
        
        if(httpCode > 0) {
           Serial.printf("[HTTP] GET... code: %d\n", httpCode);
           if(httpCode == HTTP_CODE_OK) {
                payload = http.getString();
                Serial.println(payload);
            }
        } else {
            Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
        }
        http.end();
        return payload;
 }
 void http_mod()
 {
        String res="";
        Serial.print("[HTTP] begin...\n");
        String tmpaddress="";
        if(esp32_pass=="")
        {
          tmpaddress=web_server+"/api/device/add-device";
           Serial.println(tmpaddress);  
           res=http_sys(tmpaddress);
           tmp1=JSON.parse(res);
           String tmp2="";
           tmp2=tmp1["password"];
           //Serial.println(JSON.stringify(tmp1));
           configobj["esp32pass"]=tmp2;
           Serial.println(JSON.stringify(configobj));
           save_config();
           ESP.restart();
           }
 
        else 
        {
         tmpaddress=web_server+"/api/device/status/"+esp32_pass;
         res=http_sys(tmpaddress);
         tmp1=JSON.parse(res);
         String tmp3="";
         tmp3=tmp1["status"];
         tmp3=tmp1["mode"];
         if(espstatus!=tmp3)
         {
          configobj["mode"]=tmp3;
          save_config();
          ESP.restart();
         }
         if(tmp3=="relay")
         {
          tmp3=tmp1["status"];
          Serial.print("status:");
          tmp3=""+tmp1["status"];
          int stat=tmp1["status"];
          Serial.println(tmp3);
          
         if(stat==1)
         {
          digitalWrite(relaypin, 1);
          
          blinking(1);
          Serial.println("Relay ON");
         }
         else
         {
          digitalWrite(relaypin, 0);
          Serial.println("Relay OFF");
         }
        }
        else if(tmp3=="input")
        {
        attachInterrupt(interruptpin, isr, FALLING); 
        }
        else if(tmp3=="display")
        {
          tmp3=tmp1["text"];
          if(display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
            display.clearDisplay();
            display.setTextSize(1);             // Normal 1:1 pixel scale
            display.setTextColor(WHITE);        // Draw white text
            display.setCursor(0,0);             // Start at top-left corner
            display.println(F(tmp3));
          }
        }
        else if(tmp3=="rfid")
        {
    if ( ! rfid.PICC_IsNewCardPresent()) return;
    if ( ! rfid.PICC_ReadCardSerial()) return;

    Serial.print(F("PICC type: "));
    MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
    Serial.println(rfid.PICC_GetTypeName(piccType));
    if (piccType != MFRC522::PICC_TYPE_MIFARE_MINI &&
        piccType != MFRC522::PICC_TYPE_MIFARE_1K &&
        piccType != MFRC522::PICC_TYPE_MIFARE_4K) {
        Serial.println(F("Your tag is not of type MIFARE Classic."));
        return;
    }
    for (byte i = 0; i < 4; i++) nuidPICC[i] = rfid.uid.uidByte[i];
          Serial.println(F("The NUID tag is:"));
    Serial.print(F("In hex: "));
    s_rfid="";
          for(byte i=0;i<rfid.uid.size;i++)
    {
        s_rfid+=String(rfid.uid.uidByte[i],HEX);
    }
tmpaddress=web_server+"/api/device/rfid/"+esp32_pass+"/"+s_rfid;
    res=http_sys(tmpaddress);
    }
        else
        {
          
        }
 
 }
 }

 void IRAM_ATTR isr() {
       tmpaddress =web_server+"/api/device/input/"+esp32_pass+"/"+1;
       String res=http_sys(tmpaddress);
       blinking(3);
       tmp1=JSON.parse(res);
  }






#endif //ESP32_CONFIG_H
