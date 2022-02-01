#include <ArduinoJson.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>

#include <BLE2902.h>

#ifndef ESP32_CONFIG_H
#define ESP32_CONFIG_H
//#define PORT 9000
#define USBPORT 115200
#define rfid_pins 14
#define SS_PIN    21
#define RST_PIN   22
#define SIZE_BUFFER     18
#define MAX_SIZE_BLOCK  16
#define led  2
#define relaypin 23
#define interruptpin 25
#define boot_pin 0
#define bluetooth_name "EscapeRoomDevice"

#define refresh_rate 3000
#define update_rate 10000
#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels
double version= 0.57;
unsigned long epochTime=0; 
String epochString="";


//#define SERVICE_UUID "6e400001-b5a3-f393-e0a9-e50e24dcca9e" 
//#define CHARACTERISTIC_UUID "6e400003-b5a3-f393-e0a9-e50e24dcca9e"

DynamicJsonDocument doc(2048);
DynamicJsonDocument configs(2048);
DynamicJsonDocument version_tester(2048);

String readed_rfid_code="";
String defaultjsstring="{}";



bool inputflag=false;


#define DATABASE_SECRET "DATABASE_SECRET"
#define DATABASE_URL "URL"
String ok ="[OK!]";
String dots ="...";
String receiving_data="";
String config_json="{\"wifiname\":\"Escape Room\",\"wifipass\":\"escape_room\",\"device_mode\":\"relay\",\"api_key\":\"\",\"firebase_host\":\"\"}";
String user="";
String room="";
String device="";
String basepath = "";

String path="";
String firebase_cert="",github_cert="";
IPAddress dns(8, 8, 8, 8); 
int httpCode=0;
const char* ntpServer = "europe.pool.ntp.org";
const char* fw_link = "https://raw.githubusercontent.com/karpad2/obudai_diplomamunka/esp32_szoftver/data/config.json";
const char* fw_link_bin = "https://raw.githubusercontent.com/karpad2/obudai_diplomamunka/esp32_szoftver/.pio/build/esp32dev/firmware.bin";


const long  gmtOffset_sec = 3600;
const int   daylightOffset_sec = 3600;


IPAddress primaryDNS(1, 1, 1, 1);   //optional
IPAddress secondaryDNS(8, 8, 8, 4); //optional

String json_response="";

char terminator=0x17;
unsigned long dataMillis = 0;
unsigned long updateMillis = 0;
int count = 0;
int long_pressed=0;




#endif //ESP32_CONFIG_H
