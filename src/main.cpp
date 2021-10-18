#include <Arduino.h>
#include <WiFi.h>
#include <SPI.h>
#include "SPIFFS.h"
//#include "serial.h"
#include "network_control.h"
#include "time.h"
#include "file.h"
#include <ArduinoJson.h>
#include <MFRC522.h>
#include <NTPClient.h>


#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>



void parse_serial(String text);
void parse_text_tojson(String text);
void system_update();

Adafruit_SSD1306 display(-1);
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
    Serial.println("Received data: "+receiving_data);
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
     
      link=build_link(user,room,device);
      if(http.begin(client,(char*)link.c_str())) {
        String httpRequestData ="";
        http.addHeader("Content-Type", "application/json");

        DynamicJsonDocument timejson(2048);
        timejson["lastonline"]=printLocalTime();
        serializeJson(timejson,httpRequestData);
        httpCode=http.PATCH(httpRequestData);
        http.end();
        timejson.clear();
        DynamicJsonDocument device_json(2048);

        deserializeJson(device_json,(char*)json_response.c_str());
        String  aaa=device_json["mode"].as<String>();
        if(aaa=="relay")
        
        { String a=device_json["status"];  
          Serial.println(a);
            bool status=a=="true"?true:false;
            relay(status);
        }
        else if(aaa=="rfid")
        {
            if(readed_rfid_code=="")
            {
              Serial.println("Not readed card");
            }
            else
            {
              timejson["status"]=readed_rfid_code;


              if(http.begin(client,(char*)link.c_str())) {
                  httpRequestData ="";
                  http.addHeader("Content-Type", "application/json");

                  
                  serializeJson(timejson,httpRequestData);
                  httpCode=http.PATCH(httpRequestData);
                  http.end();
                      }

                      readed_rfid_code="";
            }



        }
        else if(aaa=="input")
        {
          if(inputflag)
          {
              timejson["status"]=inputflag;

              if(http.begin(client,(char*)link.c_str())) {
                  httpRequestData ="";
                  http.addHeader("Content-Type", "application/json");

                  
                  serializeJson(timejson,httpRequestData);
                  httpCode=http.PATCH(httpRequestData);
                  http.end();
              }

          }
          inputflag=false;

        }
        else if(aaa=="oled")
        {
            display.begin(SSD1306_SWITCHCAPVCC, 0x3C); 
            display.clearDisplay();

            // Display Text
            display.setTextSize(1);
            display.setTextColor(WHITE);
            display.setCursor(0,28);
            String text_oled= device_json["status"].as<String>();
            display.println((char*)text_oled.c_str());
            display.display();
            delay(2000);
            display.clearDisplay();
        }
        else
        {
          Serial.println("Fail");
        }


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
        
        DynamicJsonDocument parsejson(2048);
        String _text=a_config_read();
        deserializeJson(parsejson,_text);
        String tmp="";
        tmp=doc["wifi_name"].as<String>();
        parsejson["wifi_name"]=(tmp=="null"?parsejson["wifi_name"].as<String>() : tmp);
        tmp=doc["wifi_password"].as<String>();
        parsejson["wifi_password"]=(tmp=="null"?parsejson["wifi_password"].as<String>() : tmp);
        tmp=doc["user"].as<String>();
        parsejson["user"]=(tmp=="null"?parsejson["user"].as<String>() : tmp);
        tmp=doc["room"].as<String>();
        parsejson["room"]=(tmp=="null"?parsejson["room"].as<String>() : tmp);
        tmp=doc["device"].as<String>();
        parsejson["device"]=(tmp=="null"?parsejson["device"].as<String>() : tmp);

        serializeJson(parsejson,_text);

        Serial.println(_text);

        //a_config_write(_text);

       
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

void system_update()
{
    HTTPClient http;
    bool update=true;
    client.setCACert((char*)github_cert.c_str());
    http.begin(fw_link);

    httpCode=http.GET();
    if(httpCode>0)
    {   String text=http.getString();
        deserializeJson(version_tester,(char*)text.c_str());
        double ghversion=version_tester["version"].as<double>();
        update=ghversion>version;
        Serial.println("Github version: "+String(ghversion)+", Local version: "+String(version)+", Thats why device is: "+(update?"updating":"not updating"));
        String txt_json="";
        String _text=a_config_read();
        deserializeJson(doc,_text);
        Serial.println(_text);

    if(update)
    {
        doc["version"]=ghversion;
        serializeJson(doc,_text);
        a_config_write(_text);
        

       // a_config_write();

        http.begin(fw_link_bin);
        httpUpdate.update(http,fw_link_bin);
    }
    }
    else 
    {
        Serial.printf("[HTTPS] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
    }
    http.end();
}


