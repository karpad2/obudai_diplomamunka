
#include "config.h"
#include <Arduino.h>
#include <FS.h>
#include "SPIFFS.h"

#define FORMAT_SPIFFS_IF_FAILED true

void a_config_write(String text);

void a_setup_filesystem()
{
    delay(200);
    Serial.println(F("Inizializing FS..."));
     if(SPIFFS.begin())  Serial.println(F("done."));
        else {
            Serial.println(F("fail."));
            SPIFFS.format();
        }
        
}

String a_config_read()
{   
    Serial.println("Try to read config.json");

    String configtxt="";
    File file = SPIFFS.open("/config.json");
        if(!file){
            Serial.println("There was an error opening the file,try to recreate it.");
            file.close();
            a_config_write(config_json);
            
            return a_config_read();
            //return "";
        }
        else{
            Serial.println("Try to open file:");
            if(file.available()) configtxt=file.readString();

        }
         
        file.close();
        Serial.println(configtxt);
        return configtxt;
}
