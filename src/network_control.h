#include <WiFi.h>
#include <ESPmDNS.h>
#include "io.h"
#include <ArduinoJSON.h>


void network_setup()
{
    String wifi_name=doc["wifi_name"].as<String>();
    String wifi_pass=doc["wifi_pass"].as<String>();

    WiFi.mode(WIFI_STA);   
    WiFi.begin((char*)wifi_name.c_str(),(char*)wifi_pass.c_str());
    Serial.println("");
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(dots);
    }
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(wifi_name);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
    if (MDNS.begin("ESP32-Controller")) {
        Serial.println("MDNS responder started");
        blinking(3);
    }
    //configTime(_TZOffset * 3600, _DSTOffset * 3600, "pool.ntp.org");
}

void system_update()
{
    
}