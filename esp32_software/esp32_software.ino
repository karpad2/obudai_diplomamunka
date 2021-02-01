#include "config.h"
//#include <WebServer.h>
#include <HTTPClient.h>
#include <ESPmDNS.h>
#include <WiFi.h>
#include <String.h>
#include "SPIFFS.h"
#include <SPI.h>
#include <ArduinoJson.h>
#include <MFRC522.h>
//#include "BluetoothSerial.h"

WebServer server(PORT);

void setup() {
  Serial.begin(USBPORT);
  Serial.println("");
  Serial.println("Setup started...");
  pinouts();
  fs_setup();
  network_setup(); 
  Serial.println(ok); 
}

void loop(void) {
  //server.handleClient();
  web_server();
  delay(5*1000);
}


String esp_id(){return ("esp32 - "+WiFi.macAddress());}
String e_id="";

void network_setup()
{
    WiFi.mode(WIFI_STA);
    WiFi.begin(ssid, password);
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


 /*
#include <SPI.h>
#include <MFRC522.h>
 
//#define RST_PIN 9 // Configurable, see typical pin layout above
//#define SS_PIN 10 // Configurable, see typical pin layout above
const int RST_PIN = 22; // Reset pin
const int SS_PIN = 21; // Slave select pin
 
MFRC522 mfrc522(SS_PIN, RST_PIN); // Create MFRC522 instance
 
void setup() {
Serial.begin(9600); // Initialize serial communications with the PC
while (!Serial); // Do nothing if no serial port is opened (added for Arduinos based on ATMEGA32U4)
SPI.begin(); // Init SPI bus
mfrc522.PCD_Init(); // Init MFRC522
mfrc522.PCD_DumpVersionToSerial(); // Show details of PCD - MFRC522 Card Reader details
Serial.println(F("Scan PICC to see UID, SAK, type, and data blocks..."));
}
 
void loop() {
// Look for new cards
if ( ! mfrc522.PICC_IsNewCardPresent()) {
return;
}
 
// Select one of the cards
if ( ! mfrc522.PICC_ReadCardSerial()) {
return;
}
 
// Dump debug info about the card; PICC_HaltA() is automatically called
mfrc522.PICC_DumpToSerial(&(mfrc522.uid));
}
*/
