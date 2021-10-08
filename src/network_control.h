#include <WiFi.h>
#include <ESPmDNS.h>
#include "io.h"
#include <ArduinoJSON.h>
#include <HTTPClient.h>
#include <WiFiClientSecure.h>

#include <HTTPUpdate.h>


WiFiClientSecure client;

bool network_setup()
{
    bool connected=false;
    String wifi_name=doc["wifi_name"].as<String>();
    String wifi_pass=doc["wifi_password"].as<String>();

    delay(20);
    Serial.println("Wifi name: "+wifi_name);
    Serial.println("Wifi password: "+wifi_pass);


    WiFi.mode(WIFI_STA);   
    WiFi.begin((char*)wifi_name.c_str(),(char*)wifi_pass.c_str());
  
    Serial.println("");
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(dots);
    }
    connected=true;
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(wifi_name);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
    if (MDNS.begin("ESP32-Controller")) {
        Serial.println("MDNS responder started");
        blinking(3);
    }
    WiFi.config(WiFi.localIP(), WiFi.gatewayIP(), WiFi.subnetMask(), IPAddress(8,8,8,8));
    configTime(3600, 3600, ntpServer);
    
  Serial.print(F("Waiting for NTP time sync: "));
  time_t nowSecs = time(nullptr);
  while (nowSecs < 8 * 3600 * 2) {
    delay(500);
    Serial.print(F("."));
    yield();
    nowSecs = time(nullptr);
  }

  Serial.println();
  struct tm timeinfo;
  gmtime_r(&nowSecs, &timeinfo);
  Serial.print(F("Current time: "));
  Serial.print(asctime(&timeinfo));


    return connected;
    //configTime(_TZOffset * 3600, _DSTOffset * 3600, "pool.ntp.org");
}

String build_link(String user="", String room="",String device_id="",bool lastonline=false)
{
    return "https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/"+user+"/rooms/"+room+"/devices/"+device_id+(lastonline?"/lastonline":"")+".json";
}

void system_update()
{
    HTTPClient http;
    bool update=true;
    
    
    
    client.setCACert((char*)github_cert.c_str());
    http.begin(fw_link);

    httpCode=http.GET();
    if(httpCode>0)
    {

    
        String text=http.getString();
        
        deserializeJson(version_tester,(char*)text.c_str());
        double ghversion=version_tester["version"].as<double>();
        update=ghversion>version;

        Serial.println("Github version: "+String(ghversion)+", Local version: "+String(version)+", Thats why device is: "+(update?"updating":"not updating"));

    if(update)
    {
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

void network_query()
{    


}

unsigned long printLocalTime()
{
  time_t now;
  struct tm timeinfo;
  if(!getLocalTime(&timeinfo)){
    Serial.println("Failed to obtain time");
    return 0;
  }
  Serial.println(&timeinfo, "%A, %B %d %Y %H:%M:%S");
  time(&now);
  return now;
}