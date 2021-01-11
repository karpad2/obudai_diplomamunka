//
// Created by karpad2 on 1/9/2021.
//

#ifndef ESP32_NETWORKING_H
#define ESP32_NETWORKING_H
#include <ESPmDNS.h>
#include <WiFi.h>
#include <WiFiClient.h>
#include <String.h>

String esp_id(){return ("esp32 - "+WiFi.macAddress());}
String e_id="";
char* e_id2="";
void network_setup()
{
    WiFi.mode(WIFI_STA);
    WiFi.begin(ssid, password);
    Serial.println("");
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(ssid);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
  e_id=esp_id();
  e_id2=e_id.toCharArray(0,e_id.length);
    if (MDNS.begin(e_id2)) {
        Serial.println("MDNS responder started");
    }
}

#endif //ESP32_NETWORKING_H
