#include "config.h"
#include <Arduino.h>
#include <ArduinoJSON.h>
#include <BluetoothSerial.h>

BluetoothSerial SerialBT;

void setup_serial()
{
  Serial.begin(USBPORT);
  Serial.println("");
  SerialBT.begin("EscapeRoom-device");
  
  
  Serial.println("Setup started...");
  Serial.println("The device started, now you can pair it with bluetooth!");
}

void bluetooth_serial()
{
  if (Serial.available()) {
    SerialBT.write(Serial.read());
  }
  if (SerialBT.available()) {
    Serial.write(SerialBT.read());
  }
}