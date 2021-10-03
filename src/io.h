#include <Arduino.h>
#include "config.h"
#include <FS.h>
#include "SPIFFS.h"
#include <SPI.h>



void button_long_pressed();
void a_config_write(String text);
void IRAM_ATTR isr();
void setup_io()
{
  SPI.begin();
  pinMode(relaypin, OUTPUT);
  pinMode(boot_pin, INPUT);
  pinMode(led, OUTPUT);
  attachInterrupt(interruptpin, isr, FALLING); 


}

void blinking(int _i)
{
    int currentMillis=0;
    currentMillis=millis();
    for (int i=0;i<_i;i++)
    {
      digitalWrite(led, 1);
      delay(200);
      digitalWrite(led, 0);
      delay(200);
    }
}

void button(int _i)
{
    int currentMillis=0;
    currentMillis=millis();
 }

void button_pressed()
{
  Serial.println("Button pressed");
  long_pressed++;
  delay(50);
  if(long_pressed>100)
  {
    long_pressed=0;
    button_long_pressed();
  }
}

void button_long_pressed()
{
  Serial.println("Factory reset OwO");
  blinking(10);
  delay(50);
  a_config_write(config_json);
}




 void IRAM_ATTR isr() {
       
       blinking(3);
       
  }

void a_config_write(String text)
{
    File file = SPIFFS.open("/config.json", FILE_WRITE);
        if(!file){
            Serial.println("There was an error opening the file for writing");
            return ;
        }
        if(file.print(text)) {
            Serial.println("File was written");
        }else {
            Serial.println("File write failed");
        }
        file.close();
        ESP.restart();
}