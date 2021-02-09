#include "config.h"
//#include <WebServer.h>
#include <HTTPClient.h>
#include <ESPmDNS.h>
#include <WiFi.h>

#include "SPIFFS.h"
#include <SPI.h>
//#include <ArduinoJson.h>
//
//#include "BluetoothSerial.h"

//WebServer server(PORT);

void setup() {
  Serial.begin(USBPORT);
  Serial.println("");
  Serial.println("Setup started...");
  fs_setup();
  pinouts();
  network_setup(); 
  Serial.println(ok); 
}

void loop(void) {
  //server.handleClient();
  http_mod();
  delay(5*1000);
}


String esp_id(){return ("esp32 - "+WiFi.macAddress());}
String e_id="";

void network_setup()
{
    WiFi.mode(WIFI_STA);   
    WiFi.begin((char*)ssid.c_str(),(char*)pass.c_str());
    Serial.println("");
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(dots);
    }
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(ssid);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
    if (MDNS.begin("ESP32-id")) {
        Serial.println("MDNS responder started");
        blinking(3);
    }
}
