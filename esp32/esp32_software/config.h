//
// Created by karpad2 on 1/9/2021.
//


#ifndef ESP32_CONFIG_H
#define ESP32_CONFIG_H
#define PORT 9000

const char* ssid=  "TP-Link";
const char*  password=  "asdfghjkl123#";

#define led  13


#define rfid_pins 14


void pinouts()
{
    pinMode(led, OUTPUT);
    digitalWrite(led, 0);
}




#endif //ESP32_CONFIG_H
