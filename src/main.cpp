#include <Arduino.h>
#include <WiFi.h>
#include <SPI.h>
#include "SPIFFS.h"
#include "serial.h"
#include "network_control.h"

#include "file.h"
#include <ArduinoJSON.h>
#include <MFRC522.h>


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
  
  user_id=doc["user_id"].as<String>();
  room_id=doc["room_id"].as<String>();
  device_id=doc["device_id"].as<String>();
  if(user_id=="null") return;
  network_setup();
  basepath = "/users/"+user_id+"/rooms/"+room_id+"/devices/"+device_id;
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
     path = basepath;
     path += "/test/int";
    
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
    setupjson["device_id"]=parsejson["device_id"].as<String>();
    setupjson["room_id"]=parsejson["room_id"].as<String>();
    setupjson["user_id"]=parsejson["user_id"].as<String>();


  }



  }