#include <ArduinoJSON.h>

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

#define refresh_rate 3000
#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels

//#define SERVICE_UUID "6e400001-b5a3-f393-e0a9-e50e24dcca9e" 
//#define CHARACTERISTIC_UUID "6e400003-b5a3-f393-e0a9-e50e24dcca9e"

DynamicJsonDocument doc(2048);
DynamicJsonDocument configs(2048);
#define DATABASE_SECRET "DATABASE_SECRET"
#define DATABASE_URL "URL"
String ok ="[OK!]";
String dots ="...";
String receiving_data="";
String config_json="{\"wifiname\":\"Escape Room\",\"wifipass\":\"escape_room\",\"device_mode\":\"relay\",\"api_key\":\"\",\"firebase_host\":\"\"}";
String user_id="";
String room_id="";
String device_id="";
String basepath = "";
String path="";

char terminator=0x17;
unsigned long dataMillis = 0;
int count = 0;
int long_pressed=0;

#endif //ESP32_CONFIG_H
