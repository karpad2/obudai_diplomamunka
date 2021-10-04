#include <WiFi.h>
#include <ESPmDNS.h>
#include "io.h"
#include <ArduinoJSON.h>
#include <HTTPClient.h>
#include <HTTPUpdate.h>



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

String build_link(String user="", String room="",String device_id="")
{
    return "https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/"+user+"/rooms/"+room+"/devices/"+device_id+".json";
}

void system_update()
{
    HTTPClient http;
    bool update=true;
    
    
    
    http.begin(fw_link);

    httpCode=http.GET();
    if(httpCode<=0) return;

    
        String text=http.getString();
        char charBuf[text.length() + 1];
        text.toCharArray(charBuf, text.length());
        deserializeJson(version_tester,charBuf);

        update=version_tester["version"].as<double>()>doc["version"].as<double>();

    if(update)
    {
        httpUpdate.update(http,fw_link_bin);
    }

}

void network_query()
{    


}

void printLocalTime()
{
  struct tm timeinfo;
  if(!getLocalTime(&timeinfo)){
    Serial.println("Failed to obtain time");
    return;
  }
  Serial.println(&timeinfo, "%A, %B %d %Y %H:%M:%S");
}