#include "config.h"
#include <Arduino.h>
#include <ArduinoJSON.h>




void setup_serial()
{
  Serial.begin(USBPORT);
  Serial.println("");
  Serial.println("Setup started...");
}
