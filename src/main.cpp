#include <Arduino.h>
#include <WiFi.h>
#include <SPI.h>
#include "SPIFFS.h"
//#include "serial.h"
#include "network_control.h"
#include "time.h"
#include "file.h"
#include <ArduinoJSON.h>
#include <MFRC522.h>
#include <NTPClient.h>



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

  firebase_cert=firebasecert_read();
  github_cert=githubcert_read();
  
  
  deserializeJson(doc, (char*)text.c_str());

  Serial.println(text);
  text=""; 
  get_config_data();
  delay(500);
  version=doc["version"].as<double>();
  Serial.println("Version: "+String(version));
  Serial.println("Network setup");
  while(!network_setup())
  {
    Serial.println("...");
    delay(1000);
  }
 epochTime=printLocalTime();
  
}

void loop() {

  
  //bluetooth_serial();
  
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
     
     client.setCACert((char*)firebase_cert.c_str());
     String link=build_link(user,room,device);
     Serial.print("Firebase link:");Serial.println(link);
     HTTPClient http;
     
     if(http.begin(client,(char*)link.c_str())) {
     dataMillis = millis();
     
     httpCode=http.GET();
     
     

     json_response="";
    if (httpCode == HTTP_CODE_OK) {
      Serial.printf("[HTTPS] GET... code: %d\n", httpCode);
      json_response=http.getString();
      Serial.println(json_response);
       http.end();
      //time_for_response
     
      link=build_link(user,room,device,true);
      if(http.begin(client,(char*)link.c_str())) {
        String httpRequestData ="";
        http.addHeader("Content-Type", "application/json");

        DynamicJsonDocument timejson(2048);
        timejson["lastonline"]=printLocalTime();
        serializeJson(timejson,httpRequestData);
        httpCode=http.PATCH(httpRequestData);
        http.end();   
      }

      
    }
    else Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
    
     }
     else {
        Serial.printf("[HTTPS] Unable to connect\n");
      }
    
   }
  
  
   if(millis() - updateMillis > update_rate)
   {
     updateMillis = millis();
     system_update();
     }
  
  
}

void parse_serial(String text)
{
    
    deserializeJson(doc, (char*)text.c_str());

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
 
  deserializeJson(parsejson, (char*)text.c_str());

      if(parsejson["mod"].as<String>()=="status")
      {

      }
      else if(parsejson["mod"].as<String>()=="setup")
      {
        setupjson["wifi_name"]=parsejson["wifi_name"].as<String>();
        setupjson["wifi_password"]=parsejson["wifi_password"].as<String>();
        setupjson["device"]=parsejson["device"].as<String>();
        setupjson["room"]=parsejson["room"].as<String>();
        setupjson["user"]=parsejson["user"].as<String>();


      }

}

