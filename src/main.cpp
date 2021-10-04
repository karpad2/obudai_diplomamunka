#include <Arduino.h>
#include <WiFi.h>
#include <SPI.h>
#include "SPIFFS.h"
#include "serial.h"
#include "network_control.h"
#include "time.h"
#include "file.h"
#include <ArduinoJSON.h>
#include <MFRC522.h>
#include <NTPClient.h>

HTTPClient http;

void parse_serial(String text);
void parse_text_tojson(String text);


MFRC522 rfid(SS_PIN, RST_PIN);
MFRC522::MIFARE_Key key;
byte nuidPICC[4];

void setup() {
  setup_serial();

  if (Serial.available() > 0) {
    receiving_data = Serial.readString();
    parse_serial(receiving_data);
  } 
  a_setup_filesystem();

  String text=a_config_read();
  parse_text_tojson(text);
  text=""; 
  get_config_data();
  
  if(user=="null") return;
  network_setup();
  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);

String link=build_link(user,room,device);
char charBuf[link.length() + 1];
    link.toCharArray(charBuf, link.length());

    printLocalTime();

  http.begin(charBuf);
}

void loop() {
  bluetooth_serial();
  if (Serial.available() > 0) {
    receiving_data = Serial.readString();
    parse_serial(receiving_data);
  }
  if(digitalRead(boot_pin)==LOW)
  {
    button_pressed();
  }


   if (millis() - dataMillis > refresh_rate)
   {
     dataMillis = millis();
     httpCode=http.GET();
     json_response="";
    if (httpCode > 0) {
      json_response=http.getString();
      


    }
    else Serial.println("Error HTTP");
   }

   if(millis() - updateMillis > update_rate)
   {
     updateMillis = millis();
     system_update();
     
   }
  // put your main code here, to run repeatedly:
}

void parse_serial(String text)
{
    char charBuf[text.length() + 1];
    text.toCharArray(charBuf, text.length());
    deserializeJson(doc, charBuf);

    if(doc["mode"]=="setup")
    {
        String txt="";
        //txt=serializeJson(doc["data"]);
        a_config_write(txt);
    }
}
void parse_text_tojson(String text)
{
  DynamicJsonDocument parsejson(2048);
  DynamicJsonDocument setupjson(2048);
  char charBuf[text.length() + 1];
  text.toCharArray(charBuf, text.length());
  deserializeJson(parsejson, charBuf);

  if(parsejson["mod"].as<String>()=="status")
  {

  }
  else if(parsejson["mod"].as<String>()=="setup")
  {
    setupjson["wifiname"]=parsejson["wifiname"].as<String>();
    setupjson["wifipassword"]=parsejson["wifipassword"].as<String>();
    setupjson["device"]=parsejson["device"].as<String>();
    setupjson["room"]=parsejson["room"].as<String>();
    setupjson["user"]=parsejson["user"].as<String>();


  }



  }